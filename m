Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08D6738FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjASMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjASMul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:50:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B623EFCB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:50:39 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o17-20020a05600c511100b003db021ef437so1179923wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vINAOHB0D9rvl5tJCPLb+x7BlTbDRMrljWXzEV7kSao=;
        b=RY7Vg6JaH9+t0kB7071r6RQ9RvqZlkoi4uMfO86SVw+7Drf8P6bD0ncXN8C0BLNqA8
         9je5xqiSIHP8K1TZLYGBHXonYih1OKWiSUB8ufrBRN3R50mWi6n7E5z8f63ttzDEJd/A
         o3LL/kQZlC0BAToxymuqN0Py96hygMil+8S/K0PefC99i7CUHQ0Ca9RDRPek+2gGvUx/
         Qjog5JenHuzIkBxdluNgDEkyHHm1e6Hdv4SFe405KYw7/tjZA9q4hOI93VCnkpXEXgyl
         gXBM7Y99pa1Vs2HHBHOrFrZKwLIYHkv244gFTIUP3Rs8H1FXADIpwirumhWYlNkCtp3o
         2fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vINAOHB0D9rvl5tJCPLb+x7BlTbDRMrljWXzEV7kSao=;
        b=gyDuR7EdKV8PphCu86AX7eZ9yCoABe8SlegOkeVkMWq4ekT1JJg4Bfr1ZFY3J8wLr2
         oxYa4UvCz0uiVjbdUfDIaGteYcQ2XI61D46pxEyzikW7bfArJT5b94Ue85NRd+pc4g30
         l26AkVx/uovnR++RCYgbABlLvW+K6NMJiTAP4Md+u5lj74LvYETY1li4XG/0sZk8JAWD
         ZF9E9QBXaCfoIW6HLJY0ksp6XHwj+aulPrZ3+uVfhNQCXJle58c1tnocm1l871Dcz11r
         B/hOxwOqPcC7uDY3VtYaYn0FbkoMYCI/UMd7uyJWzJ6a15Q18RejV8SIljvKhVK43SLe
         g7nQ==
X-Gm-Message-State: AFqh2kpvPTekBxnpLxkPaVwhy1avvC7V2yBcvjzX/p4IzNC/E+4AEihi
        j0Ttn7mupK1AnlGQvGPjoUO5Xg==
X-Google-Smtp-Source: AMrXdXulkYGRio9+cl/JJvmQN42EgGNQJ+UBCNhWNqg7IozoecnfItdDp9BbzJ1XmPi8/DKolzz63Q==
X-Received: by 2002:a05:600c:46cb:b0:3db:1afd:ac45 with SMTP id q11-20020a05600c46cb00b003db1afdac45mr4232890wmo.7.1674132638414;
        Thu, 19 Jan 2023 04:50:38 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe9c5000000b002238ea5750csm19139601wrn.72.2023.01.19.04.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 04:50:37 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:50:36 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: dts: qcom: sm8550: Add PCIe HC and PHY
 support
Message-ID: <Y8k8nEugQMO7mC0C@linaro.org>
References: <20230118230526.1499328-1-abel.vesa@linaro.org>
 <167408614065.2989059.2950818972854332656.b4-ty@kernel.org>
 <Y8jyQAR7fF1NRmwu@hovoldconsulting.com>
 <Y8kzBz0ApSWgOkVJ@linaro.org>
 <8322af81-139c-b840-dbf0-d52d86e92032@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8322af81-139c-b840-dbf0-d52d86e92032@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19 13:29:38, Krzysztof Kozlowski wrote:
> On 19/01/2023 13:09, Abel Vesa wrote:
> > On 23-01-19 08:33:20, Johan Hovold wrote:
> >> On Wed, Jan 18, 2023 at 05:55:31PM -0600, Bjorn Andersson wrote:
> >>> On Thu, 19 Jan 2023 01:05:24 +0200, Abel Vesa wrote:
> >>>> This patchset adds PCIe controllers and PHYs support to SM8550 platform
> >>>> and enables them on the MTP board.
> >>>>
> >>>> The v1 was here:
> >>>> https://lore.kernel.org/all/20221116130430.2812173-1-abel.vesa@linaro.org/
> >>>>
> >>>> Changes since v1:
> >>>>  * ordered pcie related nodes alphabetically in MTP dts
> >>>>  * dropped the pipe_mux, phy_pipe and ref clocks from the pcie nodes
> >>>>  * dropped the child node from the phy nodes, like Johan suggested,
> >>>>    and updated to use the sc8280xp binding scheme
> >>>>  * changed "pcie_1_nocsr_com_phy_reset" 2nd reset name of pcie1_phy
> >>>>    to "nocsr"
> >>>>  * reordered all pcie nodes properties to look similar to the ones
> >>>>    from sc8280xp
> >>>>
> >>>> [...]
> >>>
> >>> Applied, thanks!
> >>>
> >>> [1/2] arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes
> >>>       commit: 7d1158c984d37e79ab8bb55ab152a0b35566cb89
> >>> [2/2] arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
> >>>       commit: 1eeef306b5d80494cdb149f058013c3ab43984b4
> >>
> >> I believe there were still some changes needed to the controller
> >> and PHY bindings so this should not have been merged.
> >>
> >> 	https://lore.kernel.org/all/Y8fuUI4xaNkADkWl@hovoldconsulting.com/
> >> 	https://lore.kernel.org/lkml/Y8giHJMtPu4wTlmA@hovoldconsulting.com/
> >>
> >> Perhaps in the future you can send the dts changes along with the (PHY)
> >> driver changes so that they can be kept in lock-step and avoid this.
> > 
> > Well, that is a bit hard to do, because phy patches are based on
> > linux-phy/next, while dtsi patches are based on Bjorn's tree which,
> > so ...
> 
> ... which we long time solved by basing your patches on linux-next.
> That's the only way for inter-tree patchsets to be properly based.

Yeah, I just realized that out after I sent the reply :-)

Will send a single patchset which adds both the controller changes,
the phy changes and the dts/i changes (including all related bindings
updates).

> 
> Best regards,
> Krzysztof
> 
