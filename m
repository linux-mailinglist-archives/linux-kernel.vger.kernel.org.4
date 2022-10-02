Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40165F22E6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJBLZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJBLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:25:24 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23DE23BF3;
        Sun,  2 Oct 2022 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eznwDVhl+KXWZSTNUaz9cibBzlTZFO+DAevZ6ZHR6KQ=; b=dZ00+MA36o4tMKQMx0o+sSMNb+
        t9FSy17UGXML44O5okiYVklEZS5Wl/T4FoXQ31xtPlsfN5dcN6QeOFGQ4T55+cR6eom9W6YLkWwcg
        akOoU5Z86HQYel8+6SOJJnK8CspfzfMFoQberFcQZ7Mo1kLWRzfzY/xRQIy+boazkcPM7edDpFckR
        JmlrXiM1OwzF7/Lm5Alcf3n1L0HDX1FqyiHq1KKQ+ScLJ7uyoWMo7gV+GhiSWKEpKMYX9mIf9VtNw
        x0Ne/0mYtauwR6StOSvI/LaIlcs8e6iM85VWyh/6iFh2ETdMG2m0D61c0KBmyx9QBTrvzVJ9Uh76S
        2/QSxBuA==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:54031 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oex5y-000Uyq-C5;
        Sun, 02 Oct 2022 07:25:18 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/1] HID: usbhid: hid-pidff: Set Replay Length to Infinite
 when set to 0
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20220930225127.Horde.AdDRdase1XW5AUKNNLyXVo3@cloud.brak.space>
Date:   Sun, 2 Oct 2022 07:25:15 -0400
Cc:     jikos@kernel.org, anssi.hannula@gmail.com, linux-@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <94A49757-2F80-42B9-A853-2A891F6760AA@sladewatkins.net>
References: <20220930225127.Horde.AdDRdase1XW5AUKNNLyXVo3@cloud.brak.space>
To:     Paul Jones <paul@spacefreak18.xyz>
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

Hi,

> On Sep 30, 2022, at 6:51 PM, Paul Jones <paul@spacefreak18.xyz> wrote:
>=20
> Greetings,
> =20
> Started using my Accuforce v2 Sim wheel on Linux. I was getting no =
response from racing simulators through Wine, but native linux test =
tools worked fine. It seems that many real-world applications will send =
0 as the replay length, which was resulting in the behavior I was =
experiencing (nothing). It makes sense to interpret 0 as an infinite =
effect and therefore set the replay length of the effect to 0xffff. =
While the PID document does not explicitly state that 0 should be =
infinite, it does hint toward null values being interpreted as infinite.
> =20
> ---

No Signed-off-by?=20

Also, the formatting is weird here.

-srw

