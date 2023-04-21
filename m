Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36656EAC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjDUORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjDUORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:17:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB2D325
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:17:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b7b54642cso1728188b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682086654; x=1684678654;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQIffIkqtd6hNHJB4rxz+31IegGCQwc44vhkiOJj92s=;
        b=M24penurZN5Ee4nFVq2J7BD4sCUrtqUIh8lPS5aljmtcU1Ox0p0X92VjOD7GtUxXSQ
         qjKdwURxGzz83MBxsknjiSaH8U3TTsjUc4A1O8I/8HLb3WBkSrei1dyvYTuG9ixoQrj7
         /bdpWVqGB59CNU/kxXgCgR7kpbyby7HgpId2q28Ydgqwtptc14ZILOg4F7BbGlc9zKSJ
         Sufe4BT0xBckGuwXmMoZh7M5uLoVs16fvIdGvvMwi+HfQq6eb/4pvLxkf0ogX917XtdH
         RRhHqSAWzBrJx+nJwz6sIAPmqHgr2V3QVQ8UczZafb/JGi5sPUsuYm3gKKHcgJRNek7j
         AuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086654; x=1684678654;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQIffIkqtd6hNHJB4rxz+31IegGCQwc44vhkiOJj92s=;
        b=dE/+1AHb6k6eUcI7sxjzgFSpgDs+4ewZWDGc5SN/b06lIRue1JPKEXYWoWLvKxS9Ke
         FeJTFFd4tcPyh2spV9BrJpElXTpqNvsBeJdnYudXxEsFe2GlsP4f6p2H6ApuyKJU/AHb
         XWnba/1QntmT2dRsb/1E28zUxt/VnrlNRblCSEmY4+1toU9iLf6u8KbIdV+B+sRCt8zN
         infdMHbTEHFAleLy1X8Om2t/wOxwRBr4Zqa/3eOyXH49dB3l/ffkq3qluUsdgbFsv/gj
         BzZ/czWktKPuUznQuGdbAJatDAz7TZvuvRMnsDOUtLsgta4K5p2GnKDpi2TFzNio6Lrr
         cX2g==
X-Gm-Message-State: AAQBX9duH1zNP1ItkXisYCn9HHIlmdU0E/tOVlW2hbu7Gq2HqNFAtWc6
        NdgpKE8Ai3rBAu8BuVVeKcrPqXmCBRtMj5ZdhDE=
X-Google-Smtp-Source: AKy350bdb3f/yk08PJTy7Gw31yo5yJlBrdy60cmohpJTCzF97jblJFTMolmInY7FaADZfRydIEy6D6DeG9Mpo6jEH9M=
X-Received: by 2002:a17:90b:3a89:b0:247:6edf:e934 with SMTP id
 om9-20020a17090b3a8900b002476edfe934mr5104376pjb.42.1682086654633; Fri, 21
 Apr 2023 07:17:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:8b18:b0:bc:a2ba:b35f with HTTP; Fri, 21 Apr 2023
 07:17:34 -0700 (PDT)
Reply-To: jennifertrujillo735@gmail.com
From:   Jennifer Trujillo <edithbrown003@gmail.com>
Date:   Fri, 21 Apr 2023 15:17:34 +0100
Message-ID: <CANxB1fd_UPFdW7R_kWRuXgC_4LHL23LEDX2OgQtGD8qyVVd_0g@mail.gmail.com>
Subject: HALLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hallo,
Wie geht es dir?
