Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596546D3B19
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 02:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjDCA1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 20:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDCA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 20:27:46 -0400
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DFD6EB2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 17:27:43 -0700 (PDT)
Received: (qmail 7203 invoked by uid 990); 3 Apr 2023 00:27:41 -0000
Authentication-Results: devico.uberspace.de;
        auth=pass (plain)
MIME-Version: 1.0
Date:   Mon, 03 Apr 2023 00:27:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Leonard Lausen" <leonard@lausen.nl>
Message-ID: <32657b4f2c8cf1219b8705db6cba7606b0119274@lausen.nl>
TLS-Required: No
Subject: Re: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
To:     "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Dikshita Agarwal" <quic_dikshita@quicinc.com>,
        "Vikash Garodia" <vgarodia@qti.qualcomm.com>,
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
In-Reply-To: <12c5a8f2-3082-68a2-e973-18fb957068ac@leemhuis.info>
References: <12c5a8f2-3082-68a2-e973-18fb957068ac@leemhuis.info>
 <87edq2dus1.fsf@minerva.mail-host-address-is-not-set>
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
 <a2fec0a5855150966fa5a920216c205032965f98@lausen.nl>
X-Rspamd-Bar: /
X-Rspamd-Report: MIME_GOOD(-0.1) BAYES_HAM(-1.374321) SUSPICIOUS_RECIPS(1.5)
X-Rspamd-Score: 0.025678
Received: from unknown (HELO unkown) (::1)
        by devico.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 03 Apr 2023 02:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=lausen.nl; s=uberspace;
        h=from;
        bh=kU8/0hotsYPclOG1hg3ZENcMEY6U3LCuivpAib0hr74=;
        b=oC2wAnUm5H1OfB4XE/nU3cIGhovmM0C/NHSvx/T3dtJPxU5ClHd670Y96FE5Xpc7+cRnzBfXyY
        CqDSaOiEufS1Xt6wI74NpLW9F6W7IRr9nvJfcLJ91899z2S3hI7+fQF7AovSXO0StymLLNqzjZ+y
        jnevWcL3mzmwAGEOpIvyej/4/gY4dD6SusGrTvDWBzTDWjtrxNfV67qE5xRLZ3/kWzf6GVzWD+0/
        FBK0UXaeEwR3RFDetJK8G8Ju1ILF+ulWMaUtPksvjmYl4R+xoLmUOdP/0RIGtjghzbhw5ETnhi5L
        O6aKnvAL8SraIF6FAJRWKjdbdhXflW/J9vAXjn/rASftHFS8Ex0C5J4g+uPuxE9H06i4ytQY2QIH
        eIA/F7RFdSuc8kC2y0t6J6FUS1TGn3kKVZeY1EDwbrdcrTLG/oTzCVtuMk2f7x8gA3J6HXLXeAFg
        K7mhsONNUH0+VSP+a5Qywsu43APiNCPcZBsPmWstvlVwWecKPRYp9GG1dRigizL52jsjl5/fSnhR
        wVWN6WWwuhCmIOQmGaRcKDdT33/wcXAPxPvxiONKKIuSwKHeagUv8CkiMf/Nzuj0B7KmVZp6SduX
        3fM5TGylJn+0JX58BPPmuABItZu1WqkyCmryH9if0xay/y77h45i2s9JPguG5WTQJ9YsRtHQIK01
        0=
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

April 2, 2023 at 1:02 AM, <regressions@leemhuis.info> wrote:
> > this still leaves the regression introduced by "venus:
> >  firmware: Correct non-pix start and end addresses". As pointed out b=
y Matthias
> >  Kaehlcke, the commit prevents SC7180 and sc7280 AOSS from entering s=
leep mode
> >  during system suspend. This is a serious regression in v6.2 kernel s=
eries.
> >=20
>=20That fix is sitting in the media tree for a while and afaics still
> hasn't been sent to Linus (which is needed to get this fixed in 6.2.y).
> Mauro, could you maybe take care of that?

I see the revert made it to 6.3-rc5 as commit f95b8ea7. Now it just needs=
 to
be included for v6.2.10

Thank you
Leonard Lausen
