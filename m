Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3195767D240
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjAZQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjAZQ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:58:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26FB27D55;
        Thu, 26 Jan 2023 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=XQgEzs6b9/OuRVHRi7EBiIB5toRmsnvB2+a8TLuExkM=; b=IiLIASgwivy4pRRM4gqtuFZcEb
        cCsWoGjMeqB/DshtG/SyrIP3s8YrCleqspCKPmtXOJR61JvUl8rBU3u7C/9wERbO5UO1k+JWdmdbH
        VCTar7P91ymeGRNK74hJpgG36itZpcRGROw/tAOglIZUID3/aSGKsisq2ZnxyI5zO7d0HVi3eePZq
        EJGr+Zu+TUhbJMUVT/Ss3jodytL+ZKvmNM0y0Rk3ok4R6zuh9hnijC6extgm4D7mvK6fRYuCQqCfD
        3VGs+62SX19XXvQNVAeqO00QnhItbsM49VIkrbxP1H8zEng4F1ZS+7M/4yG3rR1T787/mV68FwYzQ
        AxIl5Pcg==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL5Zc-00ButD-9n; Thu, 26 Jan 2023 16:58:04 +0000
Message-ID: <aacad0c0-36cf-6f54-059c-7a4221e81f73@infradead.org>
Date:   Thu, 26 Jan 2023 08:58:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/7] cdx: add the cdx bus driver
Content-Language: en-US
To:     Nipun Gupta <nipun.gupta@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
References: <20230126104630.15493-1-nipun.gupta@amd.com>
 <20230126104630.15493-2-nipun.gupta@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230126104630.15493-2-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better as:

On 1/26/23 02:46, Nipun Gupta wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> new file mode 100644
> index 000000000000..8c2425fdb6d9
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -0,0 +1,12 @@
> +What:		/sys/bus/cdx/rescan
> +Date:		January 2023
> +Contact:	nipun.gupta@amd.com
> +Description:

(also capitalize Linux)

		Writing a non-zero value to this file causes rescan
		of the bus and devices on the CDX bus. Any new devices are
		scanned and added to the list of Linux devices and any
		devices removed are also deleted from Linux.

> +
> +                For example::
> +
> +		  # echo 1 > /sys/bus/cdx/rescan

-- 
~Randy
