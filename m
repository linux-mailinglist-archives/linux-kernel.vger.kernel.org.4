Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4D681407
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbjA3PDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjA3PDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:03:42 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1116AC4;
        Mon, 30 Jan 2023 07:03:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so32519888ejb.9;
        Mon, 30 Jan 2023 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LjoKg9IIWCpmfznwDQBQg5+I7y2t/W1mP0IQadL98vk=;
        b=jOHJcl+CZMZyevmTRcgFypVuXSpw/TrhSP9GH+VmtuacF3shfUXk+TJdrbzN8g8Mco
         ewlAMTNHawxokh5QSKWkuWnbxSD43wx+kbFFMRsCHIHFbOC7pARk2WVjG68wAteRC1Jt
         AZ0qdHqO+f17Yd7WP08SkBJWogHS8w4cukaucIgtprop/Gg3X815KsCzMMS+0ua9qcFD
         ubOUkQRXDOhkeIJHgb5Pgk9io4MORtRwhFql4SHQQw9rpXZF2yJk+xyXK9MlBkOaClTD
         wLFmMsjqJDShQ1hFoYPYjAD3sz9aW7HN/HzwdqtJ0J7mkDhE7kEvLTwEAXgExhv9zim4
         643A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjoKg9IIWCpmfznwDQBQg5+I7y2t/W1mP0IQadL98vk=;
        b=ZoUnPJOaib4k2a2RBdOJg1VUciMaggFJ3S3Pr5AfBvAlluqKY/aec8gZNjyEgKlWwp
         wNyzupH1Wq5Os87eW8O4ISe5sHUDrvqa135a4sA9uzNKyfMitARWIz5lag9bFS+ZcyOn
         d0nLD3bUJMoGOxhRlkxFqZSzqMnVtxGe/3hcOE1Y/zQiwUhSY2j0bypc3Zi/eUE99BvW
         nPL+pFaOSJ04CRdGk9oQ9BZzcqs7H6hvqC5IJ1AIZfUj6+s+8xQTiwg0d/LDVc0DySe7
         GzGFJ9V72yZQT+T53t5PB9rxCg0zAW+rsDOU9LSi3ts/Vq1IAQrr0061D/PPXI2qH+Sk
         2XNQ==
X-Gm-Message-State: AFqh2krK0pKaQaGNvdVDvcw06A5lLNAQD1e64h9XSbILc3T7294Kb9yb
        OKIloobL8smPU3uc9aGXPgae95h/zU0r+4sNLRQ=
X-Google-Smtp-Source: AMrXdXuRoNOaQ+UrouHilV5a0cOt6+WCe+BfGZzITf8awSdCaroBrAVZAt5cpGe8NPOJTeourc8Cqbu6WLdlTCwKWGE=
X-Received: by 2002:a17:907:2358:b0:86f:41b2:49 with SMTP id
 we24-20020a170907235800b0086f41b20049mr7578777ejb.194.1675091019768; Mon, 30
 Jan 2023 07:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20230128055214.33648-1-jamiemdouglass@gmail.com>
 <CAB1t1CwzUCEL1josABxfyqX91Z6DsrbEuopsDYsgq-eNxh6Btw@mail.gmail.com> <fd879d4e-13d7-bb82-8668-a1423fc7e428@linaro.org>
In-Reply-To: <fd879d4e-13d7-bb82-8668-a1423fc7e428@linaro.org>
From:   Petr Vorel <petr.vorel@gmail.com>
Date:   Mon, 30 Jan 2023 16:03:27 +0100
Message-ID: <CAB1t1CyGeXev-nfvgAfK+Wpny0EfyAiovNc6rH0miHzAWEoM=g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8992-lg-bullhead: Correct memory
 overlap with SMEM region
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Jamie Douglass <jamiemdouglass@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Konrad Dybico <konrad.dybico@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 at 15:21, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 30.01.2023 15:19, Petr Vorel wrote:
> > Hi Jamie,
> >
> > On Sat, 28 Jan 2023 at 06:53, Jamie Douglass <jamiemdouglass@gmail.com> wrote:
> >>
> >> A previously committed reserved memory region was overlapping with the
> >
> > IMHO there should be marked commit which you're fixing:
> > Fixes: 22c7e1a0fa45 ("arm64: dts: msm8992-bullhead: add memory hole region")
> Yes
>
> >
> >> SMEM memory region, causing an error message in dmesg:
> >>         OF: reserved mem: OVERLAP DETECTED!
> >>         reserved@5000000 (0x0000000005000000--0x0000000007200000)
> >>         overlaps with smem_region@6a00000
> >>         (0x0000000006a00000--0x0000000006c00000)
> >> This patch splits the previous reserved memory region into two
> >> reserved sections either side of the SMEM memory region.
> >
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Tested-by: Petr Vorel <pvorel@suse.cz>
> > ...
> >> +++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
> >> @@ -53,8 +53,13 @@ cont_splash_mem: memory@3400000 {
> >>                         no-map;
> >>                 };
> >>
> >> -               removed_region: reserved@5000000 {
> >> -                       reg = <0 0x05000000 0 0x2200000>;
> >> +               reserved@5000000 {
> > Can we keep "removed_region:" ?
> > removed_region: reserved@5000000 {
> >
> >> +                       reg = <0x0 0x05000000 0x0 0x1a00000>;
> >> +                       no-map;
> >> +               };
> >> +
> >> +               reserved@6c00000 {
> > Not sure which label to add, maybe append 2?
> > removed_region2: reserved@6c00000 {
> > @Konrad @Krzysztof WDYT?
> Generally, if you don't expect that there'll be a need to
> amend/reference the node from somewhere else, the label is
> rather useless..

Thank you for info. To be honest I have no idea. Previously the label
was added, but that does not mean that it's used.
'git grep -l removed_region' shows only labels in few dts/dtsi, IMHO
it's not used. IMHO it looks ok to avoid it.

Kind regards,
Petr

>
> Konrad
>
> >
> > Kind regards,
> > Petr
> >
> >> +                       reg = <0x0 0x06c00000 0x0 0x400000>;
> >>                         no-map;
> >>                 };
> >>         };
