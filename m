Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CB46D3401
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDAVAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDAVAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:00:34 -0400
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Apr 2023 14:00:32 PDT
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798471B34F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 14:00:32 -0700 (PDT)
Received: (qmail 1969 invoked by uid 990); 1 Apr 2023 20:53:49 -0000
Authentication-Results: devico.uberspace.de;
        auth=pass (plain)
MIME-Version: 1.0
Date:   Sat, 01 Apr 2023 20:53:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Leonard Lausen" <leonard@lausen.nl>
Message-ID: <a2fec0a5855150966fa5a920216c205032965f98@lausen.nl>
TLS-Required: No
Subject: Re: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
To:     "Javier Martinez Canillas" <javierm@redhat.com>,
        "Dikshita Agarwal" <quic_dikshita@quicinc.com>,
        "Vikash Garodia" <vgarodia@qti.qualcomm.com>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Stanimir Varbanov" <stanimir.k.varbanov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mka@chromium.org,
        "Albert Esteve" <aesteve@redhat.com>, stanimir.varbanov@linaro.org,
        "Enric Balletbo i Serra" <eballetb@redhat.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        "Fritz Koenig" <frkoenig@google.com>,
        "Rajeshwar Kurapaty (QUIC)" <quic_rkurapat@quicinc.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
In-Reply-To: <87edq2dus1.fsf@minerva.mail-host-address-is-not-set>
References: <87edq2dus1.fsf@minerva.mail-host-address-is-not-set>
 <20230207102254.1446461-1-javierm@redhat.com>
 <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <ef09bc9f-d570-be11-238b-bd34063917fc@redhat.com>
 <70c01751-1dd7-c4bd-a96e-94dea437aa40@redhat.com>
 <DM8PR02MB81696369DBFE619E43F81EEFF3DE9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <e87344c6-acef-7f3f-5cac-24961dbd9401@redhat.com>
 <6f97a117-0d9c-e21b-9adf-50f2233ba9e3@leemhuis.info>
 <ea283f0a-ca72-447e-ce87-68c1bbee793e@leemhuis.info>
 <CAFOAJEdBbzqkGVqw+vgNYNxyaTHwvjFyskTwjycP820L2tOctA@mail.gmail.com>
 <b548da46-bf91-6f1c-4b63-4002109056bc@leemhuis.info>
 <9a0bfef8-0b5d-f4d0-a8a5-4bbcacc5c0fb@leemhuis.info>
 <DM8PR02MB8169E16569616870A583B376F3AB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <87356wn6xf.fsf@minerva.mail-host-address-is-not-set>
 <87edq9hj4w.fsf@minerva.mail-host-address-is-not-set>
 <d18fac76-6b77-a446-5fe0-7236556e9187@quicinc.com>
 <0c84724d-08d4-ddcb-5f71-4eb8261240c6@quicinc.com>
X-Rspamd-Bar: -
X-Rspamd-Report: MIME_GOOD(-0.1) BAYES_HAM(-2.911118) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: -1.511118
Received: from unknown (HELO unkown) (::1)
        by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 01 Apr 2023 22:53:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=lausen.nl; s=uberspace;
        h=from;
        bh=aA2msNrvcbbehcgKux4cUf7WB087VIC6mCd6AEtUyEQ=;
        b=s4XtsGVE1M/EVfLROVnFJKY2m/ZJILlhO+a2J5zOVsO9r/5JzqHXwZOaORDxQewy+/oLt/E13Z
        HvywSLWvByzGU9FYoycym8dl/qvMUXsLGg76aiYxtRz6nMJTK6ObltrPRW4UXHjh49Nt5/w6snor
        uZ/vF9mVBfnhYTOKqsh/167Ga0AzjuczYNQVXHHPAxfb022TAWlmScJj1evxBryqU3t/8XGf4OjU
        Tdqcrynq20Xdv+DjkzxvJ0KElIi6CbYvd4/C9S+wu4TcVGEpjZNGByI6Ht1xE3auxBpkHazadRza
        KR8P07gnacvy3pxinaTz10ClHrkxtuqMFuqmbMV6eemFAm8+gKf7uuy7FHHbV4g8QSrVqiokM3VD
        VOCU7qDxTb5ddA+BTgHMOEoeNUfMe2ZxeZVCOv1CC11c9jzKHtGUxu3IGfEB+pqykhVSd1OMmvnu
        qSt+lruwuDGYb6fnmI0Spko/H8WYomjH8zE3F1O7TiAA06PjkpoZfXlmrvo6x0v/QU7n0vbGgEZq
        RrgV4YDpxPtJ3yzXK3VxTaxKk7VOA+LNmz/wZ8hvh3BFY/S7poQ+cJzfBkX6BGMtxd+Lgxu/wcr1
        IYadB4A2ajHkUHnNaYkufpaNtqKB/5pnw29CNGAcn+DPkO7f5BvSS5HMdBncjiuJyuaXzX/ozbfD
        c=
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier, Dikshita, Stan,

the revert wasn't applied to v6.2 series. Can you please apply it and inc=
lude it for v6.2.10?

March 6, 2023 at 5:43 AM, "Javier Martinez Canillas" <javierm@redhat.com>=
 wrote:
>> On 3/1/2023 3:15 PM, Dikshita Agarwal wrote:
>>> On 2/28/2023 9:33 PM, Javier Martinez Canillas wrote:
>>>> Javier Martinez Canillas<javierm@redhat.com>  writes:
>>>>> Vikash Garodia<vgarodia@qti.qualcomm.com>  writes:
>>>>>
>>>>>> Stan, could you please help with the revert and a pull request hav=
ing this revert
>>>>>> alongwith other pending changes ?
>>>>>>
>>>>> Other fix posted is "media: venus: dec: Fix capture formats enumera=
tion order":
>>>>>
>>>>> https://patchwork.kernel.org/project/linux-media/patch/202302100818=
35.2054482-1-javierm@redhat.com/
>>
>> Hi Javier,
>>
>> Thanks for this patch "media: venus: dec: Fix capture formats
>> enumeration order".
>>
>> Somehow I can't find it in my mailbox to be able to reply there.
>>
>> Could you please explain what is the regression you see here?
>>
>
>You can find the thread and explanation of the issue here:
>
>https://lore.kernel.org/lkml/Y+KPW18o%2FDa+N8UI@google.com/T/
>
>But Stanimir already picked it and sent a PR for v6.3 including it.

While "media: venus: dec: Fix capture formats enumeration order" may have=
 been
applied to v6.3, this still leaves the regression introduced by "venus:
firmware: Correct non-pix start and end addresses". As pointed out by Mat=
thias
Kaehlcke, the commit prevents SC7180 and sc7280 AOSS from entering sleep =
mode
during system suspend. This is a serious regression in v6.2 kernel series=
.

Best regards,
Leonard Lausen
