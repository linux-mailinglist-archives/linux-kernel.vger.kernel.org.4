Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE998602DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiJRN6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiJRN6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:58:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F59CF874;
        Tue, 18 Oct 2022 06:58:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z97so20565426ede.8;
        Tue, 18 Oct 2022 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNvg7dJc4v85iivVesuNckJ8VnSoJSGr9nvVYYYfI8Q=;
        b=MvSWiW5yn8tumonucJ27BJ1DvOPfCyCk1Eott6lHotQqjJ9KPwEMFaXOzLSM7sYYKn
         +bz8rTOJ32iFsZa+92WkVydmKZYuk12FtsbeDZrhRsAQU5FsRQVp+zgxCSfPhYVir48r
         PnNmicXzCOAxCapJNyEBpkVBnSTpYovvaKRcdI/zXNofeIkroIkPDplKxFpYtiK5MY+U
         Pt9WLxCHN8WJSQTdRa+bMk7TkDIJGhtGX3CVbluiFNQMTAn7anXnuQMGL2oxlDRGpwHY
         UBEVUH59fVwwe1xFbcU2Zql2KiC5nsgjZqmZ+xIBgg/SEeOuy4A50/n9dFwtFpuvczo3
         634g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNvg7dJc4v85iivVesuNckJ8VnSoJSGr9nvVYYYfI8Q=;
        b=FmVhbOCr4bZDgPnLw4GoJebEx3caPjRtUH32Sc0RrquU56+dDRzWPSfjmykNnOFHDn
         WNZZIMkqwvVdAzMGJbL0BskhQ5cF7l+Azibt4QWU/i4UXcl5n7LhrrAhnxQcQUksXH3Q
         dx2Lh7Hqd6Kw3F+rhvWvAcFgxwMgsWuP0YCobcKCaLq9IWlgKwrTejdLJRWruzP/LXwS
         WIVIMEQjT12r1ZcX6L3g8GA6l4xrM6i8rme73YiaeeL6GYHm6V0spcJRZVVN5IwJoqzb
         MzxAfK+++TPdwifQloS0s2S4avOXiNIT/+j6zLRNO/7gIReL9yMwYVOMXvagm7K3slFR
         TKvQ==
X-Gm-Message-State: ACrzQf1aiF+AaKTZvbasQ2qJZyn5tdzABgiRFpL16odZTnc/+GE8WJnd
        P+aqGdMGfZHISu+im7oD2zo=
X-Google-Smtp-Source: AMsMyM44JA4l96VvTHi5y+ZBj/40V5m/M6cGl/qXjUusmCeaucu0OggoXyEtHKyggzqxkuMlDTp/RQ==
X-Received: by 2002:a05:6402:1604:b0:458:b2b7:bd5a with SMTP id f4-20020a056402160400b00458b2b7bd5amr2615998edv.73.1666101519504;
        Tue, 18 Oct 2022 06:58:39 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id 24-20020a170906301800b0073dd8e5a39fsm7445732ejz.156.2022.10.18.06.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:58:39 -0700 (PDT)
Message-ID: <2f5f0c7f-4e1d-2434-51b4-d98d3fa7f49a@gmail.com>
Date:   Tue, 18 Oct 2022 15:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V2] dt-bindings: nvmem: u-boot,env: add Broadcom's variant
 binding
To:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220930163631.27040-1-zajec5@gmail.com>
 <166578177913.2909910.7600034251484225468.robh@kernel.org>
 <Y059lG8ZOXXzc4N+@wendy>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <Y059lG8ZOXXzc4N+@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2022 12:19, Conor Dooley wrote:
> On Fri, Oct 14, 2022 at 04:09:40PM -0500, Rob Herring wrote:
>> On Fri, 30 Sep 2022 18:36:31 +0200, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. U-Boot
>>> stores its configuration in an environment data block.
>>>
>>> Such blocks are usually stored on flash as a separated partition at
>>> hardcoded address. Broadcom however decided to:
>>> 1. Store env data block inside U-Boot partition
>>> 2. Avoid sticking to hardcoded offsets
>>> 3. Use custom header with "uEnv" magic and env data length
>>>
>>> Example (length 0x4000):
>>> $ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
>>> 00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..4.z.IMAG|
>>> 00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=NAND:1M,1024M.|
>>> (0x40000 offset is unit specific and can change)
>>>
>>> Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partitions:
>>> support label/name only partition") DT can describe partitions matching
>>> them by a name (without specifying actual address). With that feature
>>> and this binding change it's possible to:
>>> 1. Specify DT node for Broadcom's U-Boot env data subpartition
>>> 2. Add nodes for specific environment data variables
>>> 3. Reference them as NVMEM cells
>>>
>>> This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL needs to
>>> find environment data early (before it accesses DTB) and it does that by
>>> looking for an "uEnv" magic. Dirty way.
>>>
>>> This binding can however be used by operating systems. It allows
>>> describing cleanly U-Boot, its env data and variables. It tells
>>> operating system about Broadcom-specific env data so it can parse it.
>>>
>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>> ---
>>> V2: Work on better commit body & add example
>>> ---
>>>   .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 +++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>
>> Applied, thanks!
> 
> Hey Rob,
> Maybe my tooling is out of date or w/e but this is breaking
> dt_binding_check for me.
> 
> I applied the below to fix the build, which I was about to send, before
> realising that you'd applied it and wondered if I was missing something.

Thanks for catching that and submitting a fix!

I guess I didn't run dt_binding_check this time or I did it before
adding an example. Sorry for that!
