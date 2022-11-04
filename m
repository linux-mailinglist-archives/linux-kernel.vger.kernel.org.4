Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C24619BC7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiKDPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiKDPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0662D115;
        Fri,  4 Nov 2022 08:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C29E62238;
        Fri,  4 Nov 2022 15:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7F6C4347C;
        Fri,  4 Nov 2022 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667576073;
        bh=N1ULCwSa1AVjFUvna+kSfDT3wnar4/4rCcFLHf54/cQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qdjInU3mZIRWLYdl4ULYMh4n6qqgpfeVOsFK0e5OKfforiZOBJCBktTJARkiGFvUW
         pJrjTbEzxItf9onGDCV8UDkYzXXKY27+vk0UljwkbZKwdQyZsB8+4lCCqbzgd5UpmC
         uh+SpdQvuiEO82VZaATGzNS9fYSBlC7v5VG6GHT0CswTrdOUPgoPFbCzH4vYkRdDoh
         g1Z7IGTLFhZqqYv6/FQ9rjbxaK7Mux/z780k6RZPxSWr82fRw/FLgn+CTG2q1P0P9J
         oKj59Xy3TS9IJweULZDtQ18dv3r6WcvEQWj+HfL8b8+W67eAFdETmj7oX1eGf3L1Mc
         5ME3eWWzG5Dhw==
Received: by mail-lf1-f54.google.com with SMTP id r12so7919070lfp.1;
        Fri, 04 Nov 2022 08:34:33 -0700 (PDT)
X-Gm-Message-State: ACrzQf3+0fJ5p+KlhHLRU/+l6FxLWBZ5cJMo31z3XQz6H/vx9vm5sAWV
        eFNcVLId9UiGxKAMVjagpk3MCyjNSTJ6099azg==
X-Google-Smtp-Source: AMsMyM5bCuAPEcNkY77ckUagY268kfBLpC6XBnq51kNQiIj22Oxgyz5HDRlL7+iItfKaGJcMVhk4vtQbx4v7fRNB/2k=
X-Received: by 2002:a19:f24b:0:b0:4ab:cd12:d282 with SMTP id
 d11-20020a19f24b000000b004abcd12d282mr14031723lfk.74.1667576071604; Fri, 04
 Nov 2022 08:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-4-quic_molvera@quicinc.com> <ae4b2333-d243-17ee-1ebd-6b1c89eef9f3@linaro.org>
 <d109cbdf-1b0e-ff67-879c-d0955da4898e@quicinc.com> <9eaaf256-8de2-ddc9-ac95-aed9b0670f5e@linaro.org>
 <4832b716-6caf-cf72-1c7e-f21a0670cbaa@quicinc.com> <5109d728-ebea-21ca-3ee1-15710dfd6f1b@quicinc.com>
 <23a0dc6b-b704-c094-96dc-cf2c083ef55e@somainline.org>
In-Reply-To: <23a0dc6b-b704-c094-96dc-cf2c083ef55e@somainline.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 4 Nov 2022 10:34:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLubWBr2W3xZPsuPLOGav7CFgBdH=aCfT22F_m0_cx3cQ@mail.gmail.com>
Message-ID: <CAL_JsqLubWBr2W3xZPsuPLOGav7CFgBdH=aCfT22F_m0_cx3cQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 4:32 AM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
> On 04/11/2022 05:05, Trilok Soni wrote:
> > + Adding Konrad, Bjorn is already there in this email
> >
> > On 11/3/2022 2:13 PM, Melody Olvera wrote:
> >>
> >>
> >> On 11/2/2022 9:24 AM, Krzysztof Kozlowski wrote:
> >>> On 31/10/2022 17:49, Melody Olvera wrote:
> >>>>
> >>>> On 10/27/2022 8:21 AM, Krzysztof Kozlowski wrote:
> >>>>> On 26/10/2022 16:04, Melody Olvera wrote:
> >>>>>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
> >>>>>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and
> >>>>>> interrupt-controller
> >>>>>> to boot to shell with console on these SoCs.

[...]

> >>>> Not sure how much two-sense I have for the conversation at large,
> >>>> but generally I agree with Doug's
> >>>> point in the first paragraph. Pulls for this soc are consistent
> >>>> across boards so I don't think it makes
> >>>> sense to move them to the board files here. I vote that these stay
> >>>> here.
> >>> I would be great if Konrad and Bjorn shared their opinion on this...
> >>> but
> >>> wait, you did not Cc all maintainers... Eh.
> >> I'm not sure why this is being brought up again; we've already
> >> discussed this here
> >> https://lore.kernel.org/all/9707bf67-1b22-8a77-7193-fc909b4f49de@quicinc.com/

A bit excessive, yes. If it's just a discussion and the issue has
already been raised, add the people and move on. OTOH, imagine having
to mention the same things multiple times a day in reviews. It is
tiring.

> >> Would you like to discuss this issue here, on the next version, or
> >> not at all?
> >>
> >> On a side note, I'm uncomfortable with how our continued interactions
> >> are going
> >> and do not believe this to be conductive to continued collaboration.
> >> I would ask that
> >> we keep our correspondence polite and professional moving forward.
> >
> > I have added Konrad and Bjorn is already there on the thread. Our
> > understanding is that CCing maintainers comment is for next patch
> > series after this one.
>
> BTW: you can feed git send-email with
> --cc-cmd='./scripts/get_maintainer.pl --norolestats' and
>
> it'll pick the right people for you (most of the time, anyway).

That uses git history which doesn't really work well IMO being on the
receiving end of those. I would suggest something like this in your
.gitconfig:

[sendemail.linux]
        tocmd =" scripts/get_maintainer.pl --nogit --nogit-fallback --nol"
        cccmd ="scripts/get_maintainer.pl --nogit --nogit-fallback --nom"
        confirm = always

Then you do just 'git send-email --identity=linux ...'

Or use b4 as it does the above and works better for series.

> > Bjorn, please check and comment on above? If requires we should start
> > writing the guidelines for MSM boards since lot of comments are based
> > on the experience or knowledge in the community Vs caught by tools -
> > so it is easy to be missed by developers submitting new boards. Thoughts?

Some internal review or training for new contributors is needed IMO.
Some companies are required to have an known/experienced kernel
developer signoff on patches before they are submitted. I don't think
you want to get to that point.

> Big yes! Some of the points should probably even be raised wrt the DT
> spec itself, such as property order.

Ideally, we should only be providing comments that can be referenced
to documentation (if the tooling can't address it). In this case, I
don't think the DT spec would be the right place property order. It's
just a convention for the schema format. However, often the
documentation we do have already isn't followed, so I'm not too
motivated to add more.

Rob
