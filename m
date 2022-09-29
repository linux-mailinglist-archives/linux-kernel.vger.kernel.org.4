Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78E5EFFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiI2WKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiI2WKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:10:42 -0400
Received: from premium237-5.web-hosting.com (premium237-5.web-hosting.com [66.29.146.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2791205A1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sladewatkins.net; s=default; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O8wd9Rhvsdfifxl56tOVzOiJomq/dOcqSGReCcIFTyA=; b=jBwNcUo7/JFv8/jOTX4KGW+89t
        HpZuoVzpI5Qyi3EV7TrtFh/3Nmspc3/OmRKO/Ndkc1alZy7JO3kMEC5LMBRwyuQ++70gdFnhkXQc/
        qT/NFq/RUF7M/ZIgNf/fHJiiCh27sN/Qn8vXdsOCcqIEHEt3w/kDWjE+TX9H+joHz0q6DGqgkbL6O
        J56xR1q2ZWXwIkETWjqEri5riyY6wwUkInN3ZNuMa2SyfckyE7wq+oK3rAafZ9ZpjPs3UQh3PLrUV
        bMUp3BTd6jRfA18EeRqm5VCcyIWrhVpGPTgiATDXCFJyXue8i8jBiA41iYqZ2FIkT5mWrruqnrUn7
        puAvYWOA==;
Received: from pool-108-4-135-94.albyny.fios.verizon.net ([108.4.135.94]:58756 helo=smtpclient.apple)
        by premium237.web-hosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <srw@sladewatkins.net>)
        id 1oe1jp-006RFZ-Ll;
        Thu, 29 Sep 2022 18:10:37 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
Date:   Thu, 29 Sep 2022 18:10:35 -0400
Cc:     linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net>
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nick,

> On Sep 29, 2022, at 5:54 PM, Nick Desaulniers =
<ndesaulniers@google.com> wrote:
>=20
> I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
> Is this a known issue, or am I holding it wrong?

Hm=E2=80=A6 I also remember this. I have a Zen 2 based system that I can =
do testing on, so I will do so when I=E2=80=99m able.

If I discover something of note, I=E2=80=99ll get back to you.

Cheers,
-srw

