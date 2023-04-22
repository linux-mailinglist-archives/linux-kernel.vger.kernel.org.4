Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587876EB6DC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 04:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDVC2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 22:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVC2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 22:28:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA66A2109;
        Fri, 21 Apr 2023 19:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dStA0e+b1SYRzzHmgaCFWHkx9F8OF2AyMoR08H/BjKE=; b=aYr/TqY3YKOCT0wiQSBP9PTn1Q
        CqDmOTuvfuoBWjWRWe48KGXzRZCFpK1iN0372q8noNvtvzPDIM4Voet2L/I5igPUhStYTpfFKDgcb
        wHR+zJEDc17kgwxAp7TWdhl7gtmLwuNW2Pxfl4LvRGT2a7YfjVC+TKpH9eXRGezBr8L+T4bwfEHkI
        d3bDx4Js1wyTS1SQG8h5D8UwSMHL8pJl9fVti/AYZlgdcKuI1CcLVsMVx9KlYnNSky7stIvHDgpA2
        xwouw2fvE+tAMsgybep26Rf1FxViO+NDa5LhsjCOQnhks22f55SwkY/mGHCPH6RgjvxVHUgOpvGgf
        moj5IHNQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pq2zR-00CGC0-03;
        Sat, 22 Apr 2023 02:28:41 +0000
Message-ID: <3d151775-f72a-2261-2a2b-0a81214cca5c@infradead.org>
Date:   Fri, 21 Apr 2023 19:28:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/4] platform/x86: wmi: Add device specific documentation
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420233226.14561-1-W_Armin@gmx.de>
 <20230420233226.14561-5-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230420233226.14561-5-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/20/23 16:32, Armin Wolf wrote:
> diff --git a/Documentation/wmi/devices/wmi-bmof.rst b/Documentation/wmi/devices/wmi-bmof.rst
> new file mode 100644
> index 000000000000..b558fa46190c
> --- /dev/null
> +++ b/Documentation/wmi/devices/wmi-bmof.rst
> @@ -0,0 +1,22 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +==============================
> +WMI embedded Binary MOF driver
> +==============================
> +

Please tell the reader what MOF means.

It would be good in drivers/platform/x86/Kconfig also did that.

> +Introduction
> +============
> +
> +Many machines embed WMI Binary MOF metadata used to describe the details of their ACPI WMI interfaces.
> +The data can be decoded with tools like `bmfdec <https://github.com/pali/bmfdec>`_ to obtain a
> +human readable WMI interface description, which is useful for developing new WMI drivers.
> +
> +The Binary MOF data can be retrieved from the ``bmof`` sysfs attribute of the associated WMI device.
> +Please note that multiple WMI devices containing Binary MOF data can exist on a given system.
> +
> +WMI interface
> +=============
> +
> +The Binary MOF WMI device is identified by the WMI GUID ``05901221-D566-11D1-B2F0-00A0C9062910``.
> +The Binary MOF can be obtained by doing a WMI data block query. The result is then returned as
> +an ACPI buffer with a variable size.

-- 
~Randy
