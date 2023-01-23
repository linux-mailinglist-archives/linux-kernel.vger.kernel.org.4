Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C2C6782A5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjAWROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjAWROB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:14:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A930E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:13:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z5so11488812wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UTC6gEhOa+xaGPt1WcHKLsGLCAJskaXYya56F17FjH8=;
        b=msFk1t/L2uwetFPeRyc+weBg9Sy9kJtWuYgZn6ms2jiS3dwtl88fFY1o0BZUlooloR
         yADxfo90QGfi1cBIzpauToIdZ1ed2ZiPNlwF9/WzsVO7zv+jCHEMVj4E6/p5Ie7G51HO
         wvCcKOEX52QFU66sSxwQnKo58n53v+xGzJszibs6X0tjv/5KEhiMBDKHJTeoO9H+iegJ
         oyjCsW4v0UsPHiwF0Olhiw0HLwpXLJ8ayuCgEla5igLcQhPBuzIzFhaS8SzXEDKp+EKS
         KNYwA6ZRCkiSELNx5EUftMGhJp+46bW4MliCBZI32/hUW7fRHcnVjYvdlaUykObyQTKl
         Gw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTC6gEhOa+xaGPt1WcHKLsGLCAJskaXYya56F17FjH8=;
        b=nupWuMGnh+zkeMz3T1tjsK8X6ichgpVDv8Byw70+cgMyyE9avHTNYLlSQrv1But/MU
         wuIj2flP+vPisng+4zamR/SDltABtFJcbpA7d7lWJzzCswggnfhyFIq35aVB02mIhCyF
         yytnTBZH/Ati3hcyUtZhT6GkLeTzcgmsIhvdTIQ9EyErADMngKwBzm+mIpuMnNAKJE+b
         Y/QkC/TzB1azklwxXF8GHZVTMb+SqdnKEnnJZhJ8/vWJnuphGE/tkwnx14kWozOVZgcD
         l2Ijv2/r5dmr+P4T1zn1Z7zpdXdQ6CnaH0lt4GnQp8DtmRKT66bwO3CP8VPkVb1sEuEA
         mjfA==
X-Gm-Message-State: AFqh2krgF9HxBvNnZaOm/+xB7EYlPm0rok+S5Ktks1hDuAam+DC+c7La
        K1h0K+4efhfUl8xjkZgOQLQgdZqTm0iVAUjrvsvXcG0ljsw/FrOn
X-Google-Smtp-Source: AMrXdXvaAo8FqNudK+zMrDqlTsygTVwnFdd57HaGD8bmTqtSnGUSdNsPS+lz9iZgl+N4v0LMCknO2JMETDqCEEL+wzY=
X-Received: by 2002:adf:e2cd:0:b0:2bd:f8da:9be0 with SMTP id
 d13-20020adfe2cd000000b002bdf8da9be0mr767289wrj.375.1674494037921; Mon, 23
 Jan 2023 09:13:57 -0800 (PST)
MIME-Version: 1.0
References: <20230122173256.52280-1-didi.debian@cknow.org> <f564c135-b03c-6673-d71e-369048b1f8b3@infradead.org>
In-Reply-To: <f564c135-b03c-6673-d71e-369048b1f8b3@infradead.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 23 Jan 2023 09:13:45 -0800
Message-ID: <CAP-5=fWqzOFbtvzqOaixVo2vKZQHYdaoBW63qUy68Bwst2dsxg@mail.gmail.com>
Subject: Re: [PATCH] scripts/spelling.txt: add more spelling corrections
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Diederik de Haas <didi.debian@cknow.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 9:45 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/22/23 09:32, Diederik de Haas wrote:
> > Current Debian lintian tool flagged several (more) spelling errors, so
> > add them so they can hopefully prevented in the future.
> >
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> > As requested in https://lore.kernel.org/lkml/CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com/
> >
> >  scripts/spelling.txt | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> > index ded8bcfc0247..d53627fa9b81 100644
> > --- a/scripts/spelling.txt
> > +++ b/scripts/spelling.txt
> > @@ -65,6 +65,7 @@ acumulative||accumulative
> >  acumulator||accumulator
> >  acutally||actually
> >  adapater||adapter
> > +adderted||asserted
> >  addional||additional
> >  additionaly||additionally
> >  additonal||additional
> > @@ -122,6 +123,7 @@ alue||value
> >  ambigious||ambiguous
> >  ambigous||ambiguous
> >  amoung||among
> > +amount of times||number of times
> >  amout||amount
> >  amplifer||amplifier
> >  amplifyer||amplifier
> > @@ -287,6 +289,7 @@ capapbilities||capabilities
> >  caputure||capture
> >  carefuly||carefully
> >  cariage||carriage
> > +casued||caused
> >  catagory||category
> >  cehck||check
> >  challange||challenge
> > @@ -370,6 +373,7 @@ conbination||combination
> >  conditionaly||conditionally
> >  conditon||condition
> >  condtion||condition
> > +condtional||conditional
> >  conected||connected
> >  conector||connector
> >  configration||configuration
> > @@ -423,6 +427,7 @@ cound||could
> >  couter||counter
> >  coutner||counter
> >  cryptocraphic||cryptographic
> > +cummulative||cumulative
> >  cunter||counter
> >  curently||currently
> >  cylic||cyclic
> > @@ -627,6 +632,7 @@ existant||existent
> >  exixt||exist
> >  exlcude||exclude
> >  exlcusive||exclusive
> > +exlusive||exclusive
> >  exmaple||example
> >  expecially||especially
> >  experies||expires
> > @@ -838,6 +844,7 @@ integrety||integrity
> >  integrey||integrity
> >  intendet||intended
> >  intented||intended
> > +interal||internal
> >  interanl||internal
> >  interchangable||interchangeable
> >  interferring||interfering
> > @@ -1023,6 +1030,7 @@ negotation||negotiation
> >  nerver||never
> >  nescessary||necessary
> >  nessessary||necessary
> > +none existent||non-existent
> >  noticable||noticeable
> >  notication||notification
> >  notications||notifications
> > @@ -1044,6 +1052,7 @@ occured||occurred
> >  occurence||occurrence
> >  occure||occurred
> >  occuring||occurring
> > +ocurrence||occurrence
> >  offser||offset
> >  offet||offset
> >  offlaod||offload
> > @@ -1055,6 +1064,7 @@ omitt||omit
> >  ommiting||omitting
> >  ommitted||omitted
> >  onself||oneself
> > +onthe||on the
> >  ony||only
> >  openning||opening
> >  operatione||operation
> > @@ -1334,6 +1344,7 @@ sacrifying||sacrificing
> >  safly||safely
> >  safty||safety
> >  satify||satisfy
> > +satisifed||satisfied
> >  savable||saveable
> >  scaleing||scaling
> >  scaned||scanned
> > @@ -1614,6 +1625,7 @@ unuseful||useless
> >  unvalid||invalid
> >  upate||update
> >  upsupported||unsupported
> > +upto||up to
> >  useable||usable
> >  usefule||useful
> >  usefull||useful
>
> --
> ~Randy
