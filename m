Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208DA65FF4B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjAFLCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAFLCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:02:09 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884641665
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002929; x=1704538929;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qOPZjLWb85oTosl4Zg0QMHphA/mZ2a9oPbXY3mUvq2I=;
  b=OexMZDWawuZAhr57utLf+zXOCGgM1hMgTOXcXxMm9VxPL830DN6rN6ok
   c+5/OiMDRH748/IWyiRl50ziqkb43nf5eCowgNPvO8HxHkYy4ZY0qObFf
   eYjloBlNY+3I0yll+nav9U7UQrq3Wx8zUuQZ1iFVzalMSVw0A2VpMYyUP
   SASRt+NFGh604wPpxu5pjqANnqQS5WLWGyjyJaSFJKrZHjgb5yxUQ2kKU
   TXNzhilOt3uIevQog/q6GMsu04tkS4nCJosPvpJdkChvvoKZtddPFy7zZ
   jComJODRuyKrlmIrdU9TjnrQQRIWCK4Tv4Ugy3TSkK1YyJHyplUe5HzCY
   g==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="220280659"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:02:07 +0800
IronPort-SDR: 9cJerA1dk8wnPocbt/4zpw6LnCO87Sn8l9F4N29cHFhPvOoEXvRiW1U/deas3OtBOHON3/+ALb
 DH0Q2Qbben+S6FxOP4wpmPioJp94RwLHkv2DCXHNd4WAaIka9Ei/2b/ZqL0Wyj8mm4DEGJrBqB
 EXodn7wmIg7tXX1kz7RwK8Y1tRu1SGjWo6OIQHs8+RmfqaQiM4whBaVnqkECCNbW3lTsBaOFk3
 TtgJirSDy7G7nn2uA2o+ILJ05Ln+6DOXnOZ/0rDTzOfch5dECsCP/Sxy2npAwUjGrWq92tkmy/
 +Ps=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:20:02 -0800
IronPort-SDR: B71NulPLV9iv4lJRAL4+Zrxa9N+OXfKbytfwIB9ooNUOrqTDkw2Arm15EBQxFj0Orc7popZ/GE
 fkgbhcGPTxaUdwZSN6qURF1/l7v+jDtJHXp5zU1tC4VLwk5zSo9dyv9MfNka9JkR+KHVSDPRwR
 w/1SA2HAfU0x0e+9ibGR3fqjQN1bxmgdEZ4bebk80pgJvhkPRdMwEns0rL1lOAsGLcjnrj0lRk
 y3fLghM+4HlnvSv8efEzCywLccVbaTzesOfoPVu5GsjZTDbl8J6Qg/6HV1t35kpO5WzU1sRdiQ
 F7M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:02:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL5B5Kd1z1Rwt8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:02:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673002926; x=1675594927; bh=qOPZjLWb85oTosl4Zg0QMHphA/mZ2a9oPbX
        Y3mUvq2I=; b=emYsWRsPcpEOiygtnbX+ay8RXWSrr1fcQ4j8rreH6rJjU2nAPaS
        VzO8gx9YDdVHkW9GQBjUF6hjKzBRitRNzQ4eoiLQWjUYn2L+Q/ar7jC4fruwf8JK
        Ugy/6fnb5aO9NTjCvBqDGvL/lezCh5xnJTUniSO7/kiiSlNeEODpep5QyWihFrWV
        mKhv/s3F01NwuKnyWchz1FtyC5XtXhd2rDJIbHuCVdpJmXycoX+tfJsnxIAU5A2o
        Ah6exVQViCJ0efyk3f8XU25Z7dEYHGu1yCQWGtb0lFcKts5ykU5VRTlsIFa+bDcg
        cDnycyHYt4hoXnjVLrZ/JjkgfjVeA3wru2Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jgKMenQvintv for <linux-kernel@vger.kernel.org>;
        Fri,  6 Jan 2023 03:02:06 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL583jLFz1RvLy;
        Fri,  6 Jan 2023 03:02:04 -0800 (PST)
Message-ID: <e6216fe9-f77a-adb5-6ab4-2f86d6a86ef5@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 20:02:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/7] nvmet: introduce bdev_zone_no helper
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083320eucas1p1d23de4ad21d0a7aecb74c549ebc7757c@eucas1p1.samsung.com>
 <20230106083317.93938-4-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-4-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/23 17:33, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

