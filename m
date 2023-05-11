Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E46FFCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238993AbjEKXIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEKXIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:08:19 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8993C12
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:08:18 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-45297bbe2c6so2121142e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683846497; x=1686438497;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPER73ryVVRTIjMIzOcJeLz+gA3jNhcxkGDLzNMgB8U=;
        b=rWJeix3bKLmlR6yT7RLweg0yIBwfkPl9RAgxcgVsD7O/3+5zTmWR7fNv+X1YnY7Nwr
         cImpRXbagbHAK2pLV0ieXcfEHQI2uib7OQ/0rXnXBByYz5hRdtUSZWKRN/9QRc/pKZ+A
         98i6DCBXthavx36ptkthl7yCXcoG99xuW6gqwB82qLwWukepK6+TIK/bM+B24IKnRXqq
         p3U2c4lyE/CLvd22unBZaWWJ68WFgYOcWPYuRWMebMtoRvAf7YtMhugn2u+a8eDG5li8
         eA1vNoTg9Tn7xFO0JsO0xFcMhEn+t2Uj9ITiJb9JZLV4y65btthTAXJiL6fPpVR/R82d
         aN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846497; x=1686438497;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPER73ryVVRTIjMIzOcJeLz+gA3jNhcxkGDLzNMgB8U=;
        b=ekxczxe/s4cR7Oauoxa4l+NRPOrOM8yvH8xQNO/wbVckFQ+d04Ho1X7Gh4hYujmv3V
         72y56zq7+xxSzjsNWHNtD74beGkOZ5v0zV/8GApGQ38DjqHa6kcR/sM5FE2JPhR91Laj
         9c47qWLd3ippFfFHn9SABp0YgGYvSZQR62lKx61qeuJFm7lUGY428CvO41+0u8cfZDAH
         Snn1hth7ryePxOgrZC+61IcNfXzeLZ+0VBFsZKr1M9Xg0QmOWBzslY0wh/g+PvXiNb89
         RrGCUVUQXD5wlnamUykhsVCX9XIMVy883+GqqyAC1/BGl3za9I7tG0rAf6iAUm+6h2sU
         NYCA==
X-Gm-Message-State: AC+VfDy25gK9NE//pNhb69kzHPmvRNUKNB+Byqwa4bjPl0dxaGFFsFlz
        B8P4n3GrMWPQBCmNK8IEdKE7OG8BgJFwXALq6yg=
X-Google-Smtp-Source: ACHHUZ4rpmEwjUYuXvFbg3s4OwqpCNkPnA/wNoJIPxIGADhrnn0pxNMkmac3eKDX15bsFkKLIcuwjxlmldxygnhWtxY=
X-Received: by 2002:a67:f659:0:b0:436:120:c91f with SMTP id
 u25-20020a67f659000000b004360120c91fmr6513707vso.4.1683846496982; Thu, 11 May
 2023 16:08:16 -0700 (PDT)
MIME-Version: 1.0
Sender: mastergassol@gmail.com
Received: by 2002:ab0:274a:0:b0:779:1141:e6e2 with HTTP; Thu, 11 May 2023
 16:08:16 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Thu, 11 May 2023 17:08:16 -0600
X-Google-Sender-Auth: oPgGD7z0l-WxUD9Dcx5JfPQR5fI
Message-ID: <CAHTKmohix0kc73ONEQKbLr0yacqtfe2rctai+W-Yj-JvW4RaiQ@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Regards.
