Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D645F0B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiI3MDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiI3MDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:03:36 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A461777BB
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IBUZj9pIdHIzKYXr+IPYHirI1xyw2f8iBO3y48ztWhQ=; b=oBAM3iMHTIyCq2ySjEJBoZIhs1
        h6JGOYQyjKWdMn0P30Js2l9xVP0lOmE+48UW1VorQfmbMyiJevgaweNuyR9ZYHmEDFfDSU9x+SxT9
        fG2tlSMHEP3oF8dxqEgV0qAyec+0dP+kEmJUF20UWBOMMv3ozG2dt2Ik9y8M5Bo2IO5VKcsWO2sOK
        D098BHnSlb5to7CSCsNMUJBwoa0LQY+0yxE8oXWzO5MmmDxDUoRYz966KClu5EiXBMW8vJUJUlnc7
        x0gSMYuXqT6bN74nWgF1znbQzqomcYlFJu7AxiqdFW/fcangAgqrLgUWmpp4N9fvzLuIfO/YGO/5Y
        p0TmGn4g==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:53820 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oeEju-003JP3-Lb;
        Fri, 30 Sep 2022 08:03:34 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: BUG: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3
 through 6.0.0-rc7
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <77bc5046-7b69-6100-f991-60b4d53994ee@alu.hr>
Date:   Fri, 30 Sep 2022 08:03:32 -0400
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BD28445-7393-4153-B15C-59E5DA868E80@sladewatkins.net>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
 <47CFBECB-AE3D-4252-972D-933D2DF4A8EB@sladewatkins.net>
 <77bc5046-7b69-6100-f991-60b4d53994ee@alu.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.hr>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - premium237.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sladewatkins.net
X-Get-Message-Sender-Via: premium237.web-hosting.com: authenticated_id: srw@sladewatkins.net
X-Authenticated-Sender: premium237.web-hosting.com: srw@sladewatkins.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mirsad,

> On Sep 30, 2022, at 7:44 AM, Mirsad Todorovac =
<mirsad.todorovac@alu.hr> wrote:
>=20
> No, I did not think that it was a problem with Firefox snap build =
104.x or 105.0.1, because with the
> older 5.19.x line of kernels it works perfectly, without any crashed =
tabs or refusing to start.
>=20
> After a reboot of OS, Firefox works again, but only for a stochastic, =
undetermined amount of time.
> Once it gets "Tabs crashed" errors, it is impossible to restart until =
the next reboot.
>=20
> The non-snap Firefox 91.x esr so far did not exhibit this problem, but =
the testing results are insufficient.

Huh, okay, I=E2=80=99ll see if I can try to reproduce it again.=20

I wasn=E2=80=99t having issues with kernel 6.0-rc7 but I=E2=80=99ll try =
a fresh install and see what that changes.

Cheers,
-srw

