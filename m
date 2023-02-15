Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EEA69847E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBOT0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:26:51 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4413B659;
        Wed, 15 Feb 2023 11:26:51 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id n132so16732564oih.7;
        Wed, 15 Feb 2023 11:26:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syPlRWp1XLJqpKi4d2zS5tmfk5ekFo7ezxwYvPO/kOc=;
        b=P/OKmeMQGJfB3/Pfti9Vj83VJr3uuVprthBG3zeYFemOa7DH+ElRm6asiT4xZ8VBah
         K2HcejL/eIgQr46ROGTUjXxSL42HshYvJ8g3OiCYzfGpKx6CC/zhmauoQERfxgM9tsiY
         H/LDveKmsb4EFDvKZAJ4AzARzzcvMcI7/z9hIVto0ZN1xnhKaEIB8wu11RKwQn4pvXi6
         3o9+ZSnhtZbsq0rIRAn+fcrwH3R951owvgV+Sai83ohInRCKWor7eHRVG8PGxJDM0J4P
         DJnS9Kzyh+vs3+GOuXIGseCywI5r15/M18NRXIDbrDYQncnkHZ6FFLO5bVHOfRApjwh4
         35oQ==
X-Gm-Message-State: AO0yUKW9ZGiLUegvcMVm3k7scXbdR4/orsIkFTbzJvQDXPbNeqGGzjts
        4ddVlv+QbcFfLG8EfXLSHEkmyCKcZQ==
X-Google-Smtp-Source: AK7set+vLM9YaNIGwhZ6i/Qg//cSFLo/sNWhut07J5qaCIhhqGgnWCLhu3wZ5SddiuKUfEH8hx+zrA==
X-Received: by 2002:aca:280b:0:b0:364:7541:f9cd with SMTP id 11-20020aca280b000000b003647541f9cdmr1550479oix.21.1676489210299;
        Wed, 15 Feb 2023 11:26:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q185-20020acac0c2000000b0035a9003b8edsm7549366oif.40.2023.02.15.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 11:26:49 -0800 (PST)
Received: (nullmailer pid 435570 invoked by uid 1000);
        Wed, 15 Feb 2023 19:26:49 -0000
Date:   Wed, 15 Feb 2023 13:26:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, pavel@ucw.cz, lee@kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] dt-bindings: leds: Document commonly used LED triggers
Message-ID: <167648920872.435515.7644991846450817906.robh@kernel.org>
References: <20230213072133.5977-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213072133.5977-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Feb 2023 12:51:33 +0530, Manivannan Sadhasivam wrote:
> Document the commonly used LED triggers by the SoCs. Not all triggers
> are documented as some of them are very application specific. Most of the
> triggers documented here are currently used in devicetrees of many SoCs.
> 
> While at it, also place the comment above the triggers (hci, mmc, wlan)
> to match the rest of the binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v6:
> 
> * Rebased on top of lee/for-leds-next branch
> * Fixed the comment location for few triggers
> 
> Changes in v5:
> 
> * Rebased on top of v6.2-rc1
> 
> Changes in v4:
> 
> * Removed the sorting of triggers
> * Removed the "items" as they were not needed
> * Reworded the description
> * Dropped Zhen Lei's tested-by tag as the patch has changed
> * Added kbd-capslock trigger
> 
> Changes in v3:
> 
> * Rebased on top of v6.1-rc1
> * Added WLAN Rx trigger
> * Added tested tag from Zhen Lei
> 
> Changes in v2:
> 
> * Added more triggers, fixed the regex
> * Sorted triggers in ascending order
> 
>  .../devicetree/bindings/leds/common.yaml      | 37 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

