Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26C3697A51
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjBOK6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjBOK6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:58:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F16C728B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676458672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MmeJjSh427GKtr5aY1dE1/UGw/jLjAjyH6qeK2RMoAo=;
        b=HAtYhtDOztPg5U/LuDsg/+L7o/uf0bN0DSCBmChHmuo2alkmaRtR7MCMPAiej+0nED73uk
        /L09NrTL7fud8xexyZjclII56ylyK2pCxCePQY3V8ca+uqfDsgt2bpxbvOcYqkICqwFzXl
        Q3jf9tyixjfWWTiUP63rMlveFv7l4zE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536--Nf31OgSP3OJevRVCGeDzg-1; Wed, 15 Feb 2023 05:57:51 -0500
X-MC-Unique: -Nf31OgSP3OJevRVCGeDzg-1
Received: by mail-ej1-f72.google.com with SMTP id gb21-20020a170907961500b008b107fa657cso6499092ejc.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmeJjSh427GKtr5aY1dE1/UGw/jLjAjyH6qeK2RMoAo=;
        b=6CFBk+mOzlmoYupgdXaOnQI89QeLPpsznZFaZorNDIZxogbeqy4zGvEQ48oeqO3FmV
         MqwVAR3AZ/GCAv2j995ViZn9uPFsiQXW79hrl6CDuVsmSjivJyNhF9+AdwbfXebmAxvy
         4l2qHLypcujVmV1DdGtYouV5O/XwKJh0yesXJeSZ3ZUoxOMO4pHbuYWCDYnrATOJd9UF
         VGksHryiITIn05nEMjk7uj1SJUbantw50vJvU3k/wsMpfqGhEMAvIzbWsZ03LkbaF8as
         pA6W7uXH6sKIo882lIj3gbXIua8ANrGJrbwDJSTAhTXjUurXBUTllhEFviXY7/TC1Uv3
         SOUg==
X-Gm-Message-State: AO0yUKVIA2T0A2z725PNnotRYscn1VDBBW2nWRVW5DrjB3U1E526K3Q+
        dYEcw/3lLU4dXSoQMLsXU6dPbE6VcWTQmkdC54SrqJkvsPTsqJiZ12uRTY8VCk0tHusOCFFdszc
        c3wStRyfC1H4c5HI6615gFwoOf7JZ2dYlJy2f8KIEwFb3rA==
X-Received: by 2002:a50:ccc2:0:b0:4ac:bebb:e5fe with SMTP id b2-20020a50ccc2000000b004acbebbe5femr831738edj.1.1676458669787;
        Wed, 15 Feb 2023 02:57:49 -0800 (PST)
X-Google-Smtp-Source: AK7set+nxXB+Yb8YV5YVO81VjVBf4VZDL30eASGa9yuof5vxNU99jL1I3nSh0NSHMQMi9N7zea0BuUiOR9pDqaaa2nw=
X-Received: by 2002:a50:ccc2:0:b0:4ac:bebb:e5fe with SMTP id
 b2-20020a50ccc2000000b004acbebbe5femr831725edj.1.1676458669643; Wed, 15 Feb
 2023 02:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20230207102254.1446461-1-javierm@redhat.com> <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <ef09bc9f-d570-be11-238b-bd34063917fc@redhat.com> <70c01751-1dd7-c4bd-a96e-94dea437aa40@redhat.com>
 <DM8PR02MB81696369DBFE619E43F81EEFF3DE9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <e87344c6-acef-7f3f-5cac-24961dbd9401@redhat.com> <6f97a117-0d9c-e21b-9adf-50f2233ba9e3@leemhuis.info>
 <ea283f0a-ca72-447e-ce87-68c1bbee793e@leemhuis.info>
In-Reply-To: <ea283f0a-ca72-447e-ce87-68c1bbee793e@leemhuis.info>
From:   Javier Martinez Canillas <javierm@redhat.com>
Date:   Wed, 15 Feb 2023 11:57:38 +0100
Message-ID: <CAFOAJEdBbzqkGVqw+vgNYNxyaTHwvjFyskTwjycP820L2tOctA@mail.gmail.com>
Subject: Re: [PATCH] Revert "venus: firmware: Correct non-pix start and end addresses"
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Vikash Garodia <vgarodia@qti.qualcomm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mka@chromium.org" <mka@chromium.org>,
        Albert Esteve <aesteve@redhat.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Fritz Koenig <frkoenig@google.com>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "Rajeshwar Kurapaty (QUIC)" <quic_rkurapat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 11:53 AM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 11.02.23 15:27, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 10.02.23 11:07, Javier Martinez Canillas wrote:
> >> On 2/10/23 10:22, Vikash Garodia wrote:
> >>
> >>>> So what should we do about this folks? Since not allowing the driver to probe on
> >>>> at least SC7180 is a quite serious regression, can we revert for now until a proper
> >>>> fix is figured out?
> >>>
> >>> I am able to repro this issue on sc7180 and discussing with firmware team on the cause
> >>> of reset failure. The original patch was raised for fixing rare SMMU faults during warm
> >>> boot of video hardware. Hence looking to understand the regressing part before we
> >>> proceed to revert.
> >>
> >> Great, if you are working on a proper fix then that would be much better indeed.
> >
> > Yeah, that's great, but OTOH: there is almost certainly just one week
> > before 6.2 will be released. Ideally this should be fixed by then.
> > Vikash, do you think that's in the cards? If not: why not revert this
> > now to make sure 6.2 works fine?
>
> Hmm, no reply. And we meanwhile have Wednesday and 6.2 is almost
> certainly going to be out on Sunday. And the problem was called "a quite
> serious regression" above. So why not quickly fix this with the revert,
> as proposed earlier?
>
> Vikash? Javier?
>

I agree with you, that we should land this revert and then properly
fix the page fault issue in v6.3.

But it's not my call, the v4l2/media folks have to decide that.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

