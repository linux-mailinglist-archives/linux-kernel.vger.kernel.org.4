Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB57298E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbjFIMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjFIMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:01:00 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86421A2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:00:59 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33d22754450so7370175ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686312059; x=1688904059;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCdLKgHIUUtuyx2+snn2o5y04CytI6H9pnDS7NCXbUc=;
        b=U3xKKCZoG40FvvcIvY5k6q5Vwe/t6e4t52Bc4c85sqqC24imXQwZDPmWD1fzZcUECR
         rJazn1LWjW8jDTLCA3aX6B28tci7UjnMVFn2fHfQoLCzf7cg03e93HidCaRlm6hi9FBO
         Kme9SJZQCQRwFmICrYCSXAkLL+v2mLlW8K0uyKI9oIT7CkJbaZF0Wqii4qIsCApGx+x0
         btpn41YSmvmnJRtnt+8oTdC5ZfeOZ4/pVoKbtJwSbrC7P0gBjY8OBstF3Apfs8cTCSMg
         CsSuCE3B1ny02kuhVLV5KWjxZ3LRCaxk7s8OdYiDcWSuYF4EhFJ9+h5a1bYPDYcQoWPl
         fV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312059; x=1688904059;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCdLKgHIUUtuyx2+snn2o5y04CytI6H9pnDS7NCXbUc=;
        b=TIJBvdzWTTI/KPhTQ7u1hrZsFo3Z3/aASLsDx7vfvkRWJS/0cppegaYK2cU/ndPMGK
         Z0ZhfcSDu8mTMWw4Ja8pV9rWdz5SW1DQSBNvyuizSHKCU3fTDOLM8t53c+9fvnUpWFsA
         mqDmwTTqEbhlcbUGinFwmTwMY27+AAJGbARMpkRll1DFm+cArFY5zuy1wKvl+tmJzajq
         CxIEmPFNDfJvnSVeoux3yugWXmpUKaZbWeONfZnoVUs6z7IwiOdlsl1YHWxER6U2wPHY
         eYus+Hlgpe2z0qIm6EVLJN6qNPp19TlFnBzXOKuMHtLKuDH2BaPcCFxHheSJVUyCA2KR
         BplA==
X-Gm-Message-State: AC+VfDy0AEDc4aU/YquEGKVq8NyJRADwh1jGxuV9Tp0A7roZHwV1mnvU
        QYN6fYk9JA/1IuldWihK5oXi64qWDvoAFJGsiZI=
X-Google-Smtp-Source: ACHHUZ4rNY+qgKH2O2qoo+gKFQPQjb7RgeJJmkqlVIiwCVX9QeL286RQ3QfsubXa6tJbHvzttzNk8aThuMebdYZ/jkU=
X-Received: by 2002:a92:c80e:0:b0:33e:80a0:c32e with SMTP id
 v14-20020a92c80e000000b0033e80a0c32emr1478780iln.20.1686312058785; Fri, 09
 Jun 2023 05:00:58 -0700 (PDT)
MIME-Version: 1.0
Sender: chineduosu9@gmail.com
Received: by 2002:a05:6a11:c9a4:b0:4c5:1c1e:19fd with HTTP; Fri, 9 Jun 2023
 05:00:58 -0700 (PDT)
From:   Aisha Algaddafi <algaddafiaisha247@gmail.com>
Date:   Fri, 9 Jun 2023 13:00:58 +0100
X-Google-Sender-Auth: WOkhCJQR1yLUN8TGGZgStXmsDw4
Message-ID: <CAOyGnNi=ziPqChHGmd7ymA_at-yDq1r6TBiA-GeEaSqepsS8SQ@mail.gmail.com>
Subject: I NEED YOUR HELP.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORM_FRAUD_5,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FORM_SHORT,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to use this medium to open a mutual conversations  with you
seeking for your acceptance towards investing in your country under
your management as my partner,

My name is Aisha  Gaddaf and presently living in Oman, i am a Widow
and single Mother with three Children, the only biological Daughter of
late Libyan President (Late Colonel Muammar Gaddafi) and presently i
am under political asylum protection by the Omani Government.

I have funds worth " [ $7.500.000.00 US Dollars ] " [ $7.500.000.00 US
Dollars ] which I want to entrust to you for investment projects in
your country. If you are willing to handle this project on my behalf,
kindly reply urgent to enable me provide you more details to start the
transfer process, I shall appreciate your urgent response through my
private email address below:

algaddafiaisha247@gmail.com

You can see more on the BBC news links below:

http://www.bbc.com/news/world-africa-19966059


Thanks
Yours Truly
Aisha Gaddafi
