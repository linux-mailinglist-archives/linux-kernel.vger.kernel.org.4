Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3607365ED1A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjAENch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjAENcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:32:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122FE1A05F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:32:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso1303766wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0jTl7uinDMZAzDJ2IzZNsNPNHOyEgYexGNXlfNHfEY=;
        b=P1s6BPtqWhIJu/kAj+CFadhRfrlq2CrnIRDNwoKZINevpe4jGHK5P2IgyfJyJqS+p7
         g5ypDkHVDKP1oyLpLjiMfnsAdh1OtrkiKlqSa27PjBN6VMwjAzJjKb/taRs3CL+p2v4k
         F0mBYqyEgY25AGQOOv195LNwJOuhAbO030oL21NZS2iRbDkys8a3Qe1LwiJKyM6wgAh/
         qUTfAJBpGDg3eUAVtvn68P1h0BuP66UrHqhzSVHyiWCM2EF/RdYMbSFCSUliYeBAtgAI
         +YuRvFtFYBd2S1/yZP20SXaqqT7Qt6oyl7BibxhqXC3U7ai+JoUOV72g2bQEksCa5Yp8
         bO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0jTl7uinDMZAzDJ2IzZNsNPNHOyEgYexGNXlfNHfEY=;
        b=k06dwy4JO/fTWTG1pyNaa6ro4wCt6yrY4KdW6quxpBiRlATjS+vS1yxToljkhK++//
         FpZrLrH2BJ4oigWq7ZazGDsXzcWBpRrj1aNLTmaNacTbiZtUJ840sWveP6OOT1oSvoGO
         2H3RptEk1c47aIvixSWD9rPFa9DODJu7hC1RuLhr+/QCk3mx3i2NFDHlvTkGuI6e4dy0
         XbLlvfkSJcNP8fI6w6gHnpWNwiMhyf9WySTr5vBrewp/No5w9dYIvUtWYx4vaNusf0hM
         G7ZE+4jDswCPUSqde7hvPB/bPFmctE3oXkKaIkhxjTNVe/zFr+RpNJEar9vBNjUH6Nwm
         gpeQ==
X-Gm-Message-State: AFqh2kpWd/HBVw9j3hh3Qf4dROOY4KZEGmqx9Uq+8AYH4Wpd0cEcabcW
        /GJermVHwJDv4rT9Qc5MQaMEjdAxS/uigmgsTFo=
X-Google-Smtp-Source: AMrXdXvcRFTX27dE5vRdfUb5byKIr8N8HV9LQPNrbyCnx/9sZfoq07/MhH7NmQOI+aJgrI1L7Hj3zaBma6WpxaM4UII=
X-Received: by 2002:a05:600c:5121:b0:3d1:f143:c062 with SMTP id
 o33-20020a05600c512100b003d1f143c062mr3470778wms.128.1672925541531; Thu, 05
 Jan 2023 05:32:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:6c68:0:0:0:0:0 with HTTP; Thu, 5 Jan 2023 05:32:21 -0800 (PST)
Reply-To: a12udu@outlook.com
From:   audu bello <sd4072685@gmail.com>
Date:   Thu, 5 Jan 2023 14:32:21 +0100
Message-ID: <CALGojDhALjS9_CSL1OxzxEaN8WiwitrbfdTw7UXY38UmEu6e9A@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I've reached out a couple times, but I haven't heard back. I'd
appreciate a response to my email about pending transaction
Thanks
Bello
