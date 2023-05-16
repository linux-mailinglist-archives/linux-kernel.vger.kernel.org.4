Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2FF705905
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjEPUmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEPUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:42:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62155252
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:42:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so22363752a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684269765; x=1686861765;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ecYicVNlqCwpTD7keug9XpsIRW3LWPQcbFkS4Vo5hc=;
        b=XIClU4E1NQN1zrShL54htYb2q/NZEl/z6+bUm7qeZIRht65yH8MxJA4Ii8HcDxAaNj
         cDaVStkRVJRnJsTXcMcViR+N3TXrDd0AHbaGhtcC0etfEtXe07av3nCSZIcmxTa+ulZC
         nw9UWFDF7jWESe96v4dcPuGp5VuPAAvJXHfsbICU5oVySrd65u5kuSgSSNBj2cKSG3Jh
         hICxLMnSYC5QyAfWBvbfNPWsjbBchqnc1WsDmHRwfxNHuNpT3EZxW2dt5fl/Gd20Zqe3
         8gGHC2rdG4kAlUkot8ciJPNbtl/WTXQiXazGwlVIqUbGFOrmoKXR3B8hAzwOBRj31mvP
         BfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269765; x=1686861765;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ecYicVNlqCwpTD7keug9XpsIRW3LWPQcbFkS4Vo5hc=;
        b=Rw2VtNwwQ3g+dGhzqzvuP/8Z2zcENrNomxEwHZKj6EM/5CDAR7LvWOd2yXcGlBlpYC
         GqwZwY0pOCg5E8pRQNMtTd3aiSfAE023UlqlXgu6jiNMddQzDBeTm6jTnYf98/oRiXUL
         o4e1sr/vfejVEs7yp0IF9ehwmdop2XsmkuI+jYvMQZMfxHjVg5ti/hddFl1IyZjXWgn5
         HBC2gD0pdJQyirESSh79s5fG7LNq1zjiD5nTBoaRm9o5aC9U9bn7X8dEAIUMILuwxoFg
         Dmrr5+oQezTb4mlSEv1si7C9enL51ysOZR0h6u8eZYWelcpZbcjrZS6DVWmZIZ2ZcdUj
         Iw+g==
X-Gm-Message-State: AC+VfDz8/8SD6abmc5786DJt630WGeXcdX3X5TVMf58oCn2IQ4VUnsi1
        1WqVHPUWa/rC7Rkm1Q2orH5UtTlpBEin4OtWdzE=
X-Google-Smtp-Source: ACHHUZ4Q1DfgDg3zEdFYP+t061/iCddkRIqKmLL3FPtAQnFzl6DU8PEp4U9KIYwRx2MMNKG1XUD2xiah6OXxzwJcxpU=
X-Received: by 2002:aa7:d659:0:b0:50b:d305:3788 with SMTP id
 v25-20020aa7d659000000b0050bd3053788mr354820edr.11.1684269764864; Tue, 16 May
 2023 13:42:44 -0700 (PDT)
MIME-Version: 1.0
Sender: munniralhassanmunniralhassan@gmail.com
Received: by 2002:a05:7208:4222:b0:69:8066:c3d9 with HTTP; Tue, 16 May 2023
 13:42:44 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Tue, 16 May 2023 14:42:44 -0600
X-Google-Sender-Auth: O8UR8YA9MsZ_wOjsk_-PWAWkMDY
Message-ID: <CALefQgMDR9X7RGQsP84smPzVDpHb=kXv4Hz1juZAKm-GRO-e4w@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

 Hope to hear from you
