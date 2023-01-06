Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D341B65FF48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjAFLBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAFLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:01:22 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE3E71498
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673002873; x=1704538873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ydpjo/PG9rszJfVuf0/cnxIuUewKQhm2ZsznqLALiPE=;
  b=gmA1zTvYyCfXacF54EJjqlFj3RBdcr+XF6HlgfNJxXXp/ckXmY4mE2rg
   rSnwB87/vA/u6SHK2uNsLfmLWlBIzWAkxAtKbUVoa645UEbK1tEoQ9cN0
   DI3kss5xUWAIhlIALDwRF60CwS7qWxJ5p8IcJXedeo3WJO8InRBljYFxd
   43EUloJfFVJvXqJXdK/TVUiuiSB3jjJfiS5boGNsplJwJtThoFlBPyTEw
   O2CCC+4l9VYhG0O2V/mROaNKzJ9K4g7SJAvo/h/bhfYbvKTRkRnEUfA5H
   CLJ7NPCCpnPb1hiozJ0/WkbDh9QwYAaHyehbyW+LTsHBj3J0mbyYTce0B
   g==;
X-IronPort-AV: E=Sophos;i="5.96,305,1665417600"; 
   d="scan'208";a="332176808"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 19:01:10 +0800
IronPort-SDR: jXZ9zb/weTMyeA8XFC+SsEJ5pXRRCcbBtb7gganr4X9OCEa4ZIokj5a7sUEoSZ5KucVJdDX7Fu
 EScjoyobNXG51OUkYoHJh3a6urLT/AQqhK4OAnzzjWKL0IJ6lMz9veeUHjhXsVPfp6SSeinRFk
 vbiJZyLAP9vM15qSS6Z5ZEC1JUYAnX/mCBV5+MUV6pzuAWZ+5HkbbZ9zwrLiNHmcCGo1LbEoXT
 zquoAHNUzJ/37KuBWq9SzVKdNw1MrR9SZSgLLtSJWLk0mrd/0s6HhkbC/8uiSARcCYKhBDoGvg
 Q/M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 02:19:05 -0800
IronPort-SDR: F2npbCBETYWb06hnwW2AfxpNr6FJC0qFJGXXdR5VAs68LONffKubxNPAlH1Xp1gGsi7BqB9R19
 8MWNJz8hzf9y+yBuuKqfSYgB0OQffia21SrBeT1XfuinzrDjfd0EVi6JiEp6RTVNgQ67728bKd
 slr1Ptz5CdyCuLuAPsHn2uBZAK5OGjjCqfWI23J38gxBjOH9+0t4CAmED7libP+2LoY4Rw4FIY
 PTVUld3r13+teydKdoXzhUNUCIwVKgFtOKtOxgLNO4FQqQEyBaaGjbDaFxqV/jUrEjjLk9UBfB
 K70=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jan 2023 03:01:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpL462nG4z1Rwtl
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:01:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673002869; x=1675594870; bh=ydpjo/PG9rszJfVuf0/cnxIuUewKQhm2Zsz
        nqLALiPE=; b=aE9aLrbAxdk6xM3YjipPdKlKR+YBrKVCr7tYG5UMv/LfblT78Jz
        zZHTm9i+K1jvg4YO+cnrNRbVEkzQE+S6XyHCkv/8P6gt4mxRqqOjFxqi4qVbpM2k
        Cm8m2wgwu2SWy+zEQiSotsjNMFsjRXmbWLiRxY8xtgN03ctFd81o7d0F/CEuwfJG
        80b/4o0zu30Ut0aQ0x+fqiwGii+AZi9H1iGjhraY9fedjAkzGoK/wfXhYOLeL2KT
        EheQMkJXTKvT0Y/xJsz4/T5jsgFhuc80MyVBvlugUgUFdyKOSR8UjewAplW3FZyJ
        53LzhVSbb7FzBzKDvirJAcdxtEV9WO/SRwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H_yAGvz8t-Z5 for <linux-kernel@vger.kernel.org>;
        Fri,  6 Jan 2023 03:01:09 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpL436MGRz1RvTp;
        Fri,  6 Jan 2023 03:01:07 -0800 (PST)
Message-ID: <22e12d95-d00d-270d-8119-8587672976a7@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 20:01:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] block: remove superfluous check for request queue in
 bdev_is_zoned
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk
Cc:     kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
        hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <20230106083317.93938-1-p.raghav@samsung.com>
 <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com>
 <20230106083317.93938-2-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230106083317.93938-2-p.raghav@samsung.com>
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
> Remove the superfluous request queue check in bdev_is_zoned() as the
> bdev_get_queue can never return NULL.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  include/linux/blkdev.h | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 43d4e073b111..0e40b014c40b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1283,12 +1283,7 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  
>  static inline bool bdev_is_zoned(struct block_device *bdev)
>  {
> -	struct request_queue *q = bdev_get_queue(bdev);
> -
> -	if (q)
> -		return blk_queue_is_zoned(q);
> -
> -	return false;
> +	return blk_queue_is_zoned(bdev_get_queue(bdev));
>  }
>  
>  static inline bool bdev_op_is_zoned_write(struct block_device *bdev,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

