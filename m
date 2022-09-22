Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE085E6077
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIVLG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiIVLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:06:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C486DE0F8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663844759; x=1695380759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4khpOzJ+xAoEzXavzdtwAPfYs0FdBngUJHQblA2ykV0=;
  b=0A+XTVN7H0ckKHt8nwA/1nMMdOkivkaxbuqv7BpT8LX/YRO1fe/WhRXr
   t/DlbhfuLKhxKOwwjv+Eq8IrhRIqYeLOJyZznRd9R3I7u1tfJPR5PO3Nc
   7KXzIqiqIFj7c32wVJPD5JWgM2Al1Vy8LdH26dJIaSsXcHbPcSBQwQQpC
   MqKL4ycYi4+mK6uyhC8MwpwbNmyiKuE2RZDykpDnJ0nlD4g7XqmIMio6v
   0m+pW7cdr3kCIAZUlUv+P7E6ubcIp4bdnopRJZcWXTBmRnN60IEvpwxEn
   CRYDCFo7t8iZncURmfvWdqc1BRFLSgl8+0zYjoIgwtgISSZd6U0KCX6Cq
   g==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="181501572"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:05:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:05:42 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 22 Sep 2022 04:05:41 -0700
Date:   Thu, 22 Sep 2022 12:05:19 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <cgel.zte@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH linux-next] scripts/extract_xc3028: use absolute path for
 which
Message-ID: <YyxBb63/8MdaxxvC@wendy>
References: <20220922102624.236308-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220922102624.236308-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:26:25AM +0000, cgel.zte@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>

Hey Xu Panda,
I accidentally found this patch while looking for your RISC-V one on
lore.

You've not CC'ed any maintainers so I am not sure who you expect to pick
this patch up, but seeing as Greg has NACKed the patch you sent to the
RISC-V list [0] earlier doing the same thing I figure it is a moot
point... maybe engaging with maintainers rather than sending more
patches would be a more successful strategy for you here :(

Either way, you'll likely have to resend this with a maintainer CCed for
someone to be able to apply your patch once you've resolved the email
issues.

Thanks,
Conor.

0 - https://lore.kernel.org/all/Yyw24J7YFVtxsnJ7@kroah.com/
> 
> Not using absolute path when invoking which can lead to serious security
> issues.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  scripts/extract_xc3028.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/extract_xc3028.pl b/scripts/extract_xc3028.pl
> index e1c9af25a595..c9ddcba07550 100755
> --- a/scripts/extract_xc3028.pl
> +++ b/scripts/extract_xc3028.pl
> @@ -29,7 +29,7 @@ sub verify ($$)
>         my ($filename, $hash) = @_;
>         my ($testhash);
> 
> -       if (system("which md5sum > /dev/null 2>&1")) {
> +       if (system("/usr/bin/which md5sum > /dev/null 2>&1")) {
>                 die "This firmware requires the md5sum command - see http://www.gnu.org/software/coreutils/\n";
>         }
> 
> -- 
> 2.15.2
> 
