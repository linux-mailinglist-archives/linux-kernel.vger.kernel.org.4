Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C76749045
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjGEVva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGEVv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:51:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C5198E;
        Wed,  5 Jul 2023 14:51:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b89b75dc1cso8507565ad.1;
        Wed, 05 Jul 2023 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688593883; x=1691185883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/f4NSacruzrqLRNLsG0mri8oBqqaQJZoZ/9yh5I+yG8=;
        b=CWL1Hj7SVYGwFiVSthIUflg0h5PJ6693n5CkPS+Mr7DTfTS+26N5OfALQuYuAF8J2O
         SqErgCtwFzD8yYNWdRBCpbO08acZVDStI1uo5E0gRZXFylEBZiRhB5KSzApPQOkmCFmu
         FkmQNIu2cOc8EGj4kGWR0nHx9FCIyL4nhypQIoShkn2xTJtTOIbnXq0PClrBe09OzW/O
         dY3kbYG4UzAIc4Embtl7njE8uyzjzaK5zZbfE+gPaZ1NyUn53D3B/L+2rZoFYIit3JfL
         2rBdM69Qa5RuT2ubd0XHIBmLySwdrA2qSPjYER8dHZ84YLqt2xHFQn5u9ft6tLstYTGs
         Pzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688593883; x=1691185883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f4NSacruzrqLRNLsG0mri8oBqqaQJZoZ/9yh5I+yG8=;
        b=HPZq6ovFQYgc9T1ckHqaBM0Rn0XiYr645Dso3xwvYCxymqgOfO19kc20OQ+tycFd35
         G/uH44V3zTzgdINtNuJ/p2SdcMvcg92z/LdMfqZMhK5RfrxT3eDF/xoIlwbpkoZ8W/s/
         ob3xE2TXr/BzUBYv5jaxtYXaAgedirkeey31aVlF0CVbGfy7dDBS3pkpEkgJ5xRPlqa6
         4CLDwgUGzwNx83rt6tcb6wZvT24sCmpfqVerxewiaKjYKVUC5qFp+HDzsC5tk6N1RJrH
         rphVMydYuI60Em2lOP77kWI0vvYhPFyYJpa7KuC01Bx+xO0Rt8i6Q2cD5FGDcyBvT0Iz
         m/xQ==
X-Gm-Message-State: ABy/qLaSEFRzx/j9zp/1nLZPD15f1jDe/Mu4Pye1ocxuxXn3LgBnA1Xi
        4Kex5OCie1hAmfGGOe7C+es=
X-Google-Smtp-Source: APBJJlHC6QajUJju9idxPQqMCy0s5VLp/4JCE1hOicV27Giagl5D7Cg0OZSl0N4vfGxmKnoaxWxJKg==
X-Received: by 2002:a17:90a:cc0e:b0:262:ec12:7c40 with SMTP id b14-20020a17090acc0e00b00262ec127c40mr447318pju.11.1688593882959;
        Wed, 05 Jul 2023 14:51:22 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9fac:a99f:7f0a:397])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090ac98200b0025bbe90d3cbsm49368pjt.44.2023.07.05.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:51:22 -0700 (PDT)
Date:   Wed, 5 Jul 2023 14:51:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v1] Input: cpcap-pwrbutton - replace GPLv2 boilerplate
 with SPDX
Message-ID: <ZKXl2JBvxYfLyEA+@google.com>
References: <20230705212231.631525-1-sre@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705212231.631525-1-sre@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 11:22:31PM +0200, Sebastian Reichel wrote:
> Replace the GPLv2 boilerplate text with a nice and short
> SPDX header.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thank you.

-- 
Dmitry
