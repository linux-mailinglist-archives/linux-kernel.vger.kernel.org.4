Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB537272B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjFGXJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFGXJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:09:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4BD1BC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:09:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-4f13c41c957so10596e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686179347; x=1688771347;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmuVHgQTGSW4pBgLHyr3r3J1G7KlM6k/vY2ryTt9UVA=;
        b=gxrVTxAB285MdXgb80hgStxgDNV5Cl2q79sQCGOF6Fbp2eyEmcgQ7AUTTHqEkEFdC8
         EN9KcSYeZSWUzVM9K4uQnUsQseKe+3ztwELVGK/jqCHdEVuLbTsfPeNrg1T2YvEBP9Es
         6jNGrmh8wcTTupXSAZpffBuqQexZD6L707oqD3zQ4IKa2RpUATccn1bdglFigFEp476g
         HtXNxsasGcBq3GOQ4U2+7tC7IO9I3kxQ/czo9zCACYPOZWCzJyO+tAsyfQvZ2Xi52QO0
         AE9wYetaL2nBMgJFTVeHkio2q9KI+G4S+mHL7I+abrSUCOmKm651YtstslCqhLUdqHis
         CGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686179347; x=1688771347;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmuVHgQTGSW4pBgLHyr3r3J1G7KlM6k/vY2ryTt9UVA=;
        b=MClh4um7wsttsPwa7MLn9RAWfrYpEU9lVS99x8DBNuhuBKS6P+rarI9kfLA8i5FxLu
         cx/8aDraI7MBUZ2zRXUQs7lXRWFEC9TWmT/IQt4nCktrjd4h/avK5A+ITtVPNbnqafmo
         WZcXg4eFvXm4XBfLU4fDnLgqU+zcOMVF1s7dCHx9kWDvC158oPHBCKEgY/mVNnhhfydC
         DxCHRbLhG9c6eT8/D+OUZoRkHzRNI8hwhAsF+oSObloErP3bs3xc7jkkVednJ3VbRu2+
         JGLsunYQvcbe13umBR639c1AcR6dKY8QxPUAaZQehBXGLWjmdFT0z020r3Uec7N+x8dy
         YxPA==
X-Gm-Message-State: AC+VfDzaRKum0dOinfoFq/IklrwasO7iPpv6lgEOVxLEOGjmP1/YQr/F
        33VyrhvWYoBrSiPgDFEzqr/lpNO29SeUX+qrhDs=
X-Google-Smtp-Source: ACHHUZ7eYszHqq28NjvxeNuv9+mRdUrrTZMcIkNaF4h9mjPWha8Ti3rB5Cxln9iFktzChvWGViJFe5H99O4Nzpnsh3s=
X-Received: by 2002:a2e:aa1c:0:b0:2b1:e724:4d08 with SMTP id
 bf28-20020a2eaa1c000000b002b1e7244d08mr1310999ljb.4.1686179346484; Wed, 07
 Jun 2023 16:09:06 -0700 (PDT)
MIME-Version: 1.0
Reply-To: dr.zeida.chedsworth1@gmail.com
Sender: edrrreeee@gmail.com
Received: by 2002:a05:6022:a307:b0:40:d448:1cfd with HTTP; Wed, 7 Jun 2023
 16:09:06 -0700 (PDT)
From:   Dr Zeida Chedsworth <dr.zeida.chedsworth1@gmail.com>
Date:   Wed, 7 Jun 2023 16:09:06 -0700
X-Google-Sender-Auth: GMGcoW8ugErF9bB43FPyyiUZc9Q
Message-ID: <CAF7czdqgqO-t8u4dRPyVfQB3ode76aFSaKpdDoZrCY8YEEu71A@mail.gmail.com>
Subject: Good Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Friend,

I have a client who has indicated interest in investing overseas. He
also intends to partner with anyone with a good knowledge of business
in the country of the investment who shall act as the Managing partner
as he may not be able to relocate out of his country at the moment to
manage the business because he holds a political appointment with the
government. Please, if you're interested, reply for further
discussions. Contact the director here for more explanation Regards
Management,

Dr Zeida Chedsworth,
