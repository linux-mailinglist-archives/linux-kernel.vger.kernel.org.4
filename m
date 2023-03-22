Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D76C5A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCVXdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCVXdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:33:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713931ACFD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679527988; x=1711063988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i1XoAW8z7ZlnXmP1BOCiZLmkFKR4eXdDx/+YjqK6+zw=;
  b=hIQEFtdbJoymV9QvDcJ3wcEHatx1evGDhjdrQ3SN9XICMkSTKI3IHC6u
   oR7K0xjToEptyqFe268QSHdAh8MVn5tRwbaItSuTkO2HS2UrNWlY641Vq
   kpewKTaYn7hnIUrkfDKe7idOjm2vrbQDv/9pU9XHZu8iJu8jCGTJGJG4N
   Htxvs+kVLkvdIBfhN25yL1oo0mVbmULhBYicSDlAZCYOxa4Jh7cw5sD9H
   Gf+xOgJqBEYvZO8WYuZF33PGX+mjDR6XzWaqTk3lsUjwFavPxfzcbmrDv
   c1rKvx9bkdGRG0RWXgOe1hJA59ho1snEFWfnuw/pgBDJpxfbKcNpsuhKA
   A==;
X-IronPort-AV: E=Sophos;i="5.98,282,1673884800"; 
   d="scan'208";a="226273135"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:33:07 +0800
IronPort-SDR: hQq3fhX7RA273WMVTSkWphlJwGnTzQ5XQ1DuAQoEu20dxbz7wzFmFYyeG0NV7KCcmFzwA9Tamh
 0qGYl2ZBl6xGHWoNSYjJxzMF4RNgS68SvqefMEZOKfdRl8U+kptoCRRXbRSpYswantzncanIMD
 nBZvoRY5s5WoW/DeesbR3pIQIyeNxWA8SDXuRDE01G0LQV41mXSoCUk1V6i7GJSbbByripuSnP
 pvYLBCBETztwRHrVyB6tixtIhKCL89qPTURZ4cHSf3gfw+bazVtFkwr+Rbtr8B/kw0f5HwSQ47
 0c8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:49:25 -0700
IronPort-SDR: AiPIw//BMdB6163W+5r1zwCmN/EaIe9PctW2fB0p96aZh7l56RP9q/ezqWD3s3qNssn8BxxC6T
 mjzDE1l5P9hmSTjp7gtlzHJACZZMhu8l/Rc0w02hCBaIxHGMBOLl9xpsbg6fFb/rGcR5r/o716
 aTxONBa8Dyj0Ky5+qkC2J7sgxnPCkjLLS4LXYiAnVhFhjUrWGguetOW8pbOKiHv0XT5JICjv7v
 KoGnF0feB3LoMtzwjCuUU03lmZ2LG3s7vPl5WHjtjwRlrBP4o6zADhcSK++kV9xVMCmdKgpmAh
 fIw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:33:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlC75j0gz1RtVp
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:33:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679527987; x=1682119988; bh=i1XoAW8z7ZlnXmP1BOCiZLmkFKR4eXdDx/+
        YjqK6+zw=; b=Ntpd+c2YF023jHm2Zo1gzXiM0Rp4SjqXqaY0FfYf6oTjYywA6rz
        uy+eBN/2vYmD16JQOinnJAtom31b/4oGE5613EBKrIe/PII7nkYgYNZztj2i4NBN
        X2KnECyIcG1jGCkItFiET9Y9VXtGpXrUGYlNspagGUjH9UJDc9cKVxkexOdXELIO
        /XDi5E6dMp5mrJWhjHQSc7N65K0hQp+pgfqPqWiuUnBSEk2Akw8hxTgJ8ULg0uIm
        xKBak2BuYgNwViaFCxskTl8j4KqIPeMZ5RDPQm1IkuSipjr2bBynhguTweLv+rAr
        5NjA4RcOAQi54SO9f3w9j9vBi79rcUSjytg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y1HRkBUfN59Q for <linux-kernel@vger.kernel.org>;
        Wed, 22 Mar 2023 16:33:07 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlC60QH4z1RtVm;
        Wed, 22 Mar 2023 16:33:05 -0700 (PDT)
Message-ID: <435fb998-daad-3c09-ad15-f31713b0c3b9@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:33:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 03/10] erofs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-2-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-2-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 01:58, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

