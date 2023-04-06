Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC696D90B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjDFHoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjDFHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:44:02 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635267A9D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:43:46 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id br40so6102567qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680767025;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb6058K9B4SaoDb25lEzgGC+N/lj0Y4i8kKZpeOcWj8=;
        b=ngQX4eOeMcNbN/mXQcUiSYrASR3Vybs1kLBRRlcbnYDkjxF27ME6QaotwhchqrNkBd
         fDdgTOZrphTNU2cTo6Y83qrpFSWiYoHaN1jbxbFCHTKmawXe0r6t9INloLgr+DSc4MG5
         kmVyx5QCWQsdoQ5/n8KZhVQZdWIZepEMfE41Tb0uglFVDu4RtDuCd0MzhBrMtcD9eXkU
         1b09mUxcaGH6Ab0rpaWnBJr5drCKYA1p3Uy6FQjB8CIAXq4nRrBUquvJXqxgWE1cSiV5
         QuehLbJo4znN488HAylpEJTB97C26qVjGqRsLq4aFipGRMEC6ca3WFSeTeDEX5tmkm7t
         AA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767025;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb6058K9B4SaoDb25lEzgGC+N/lj0Y4i8kKZpeOcWj8=;
        b=Cptc9fFkw6aqTz9uNN6qowY1OEo0d7a70vp6mKhApogh9Gas8EgO7SA8PQY8FUVnju
         VMlb/nmX6SCQHxg8c8dm4Gve90pUXrIbk7jzju6tjGHexO5ga3jDPVKXo8cbdBemDNw/
         jKBAs1OqXGlWvgaBVHR3ftdsxoUnx/SgBVQvf2TSb3U4wT7smYOQp99MVovZqsFpATnA
         ITiRlw6xqo9bTMXiBrZA5cWTM2uJSfSKFI85ZgaaMyokYm8XbLDEwIj1uLknGZobYQT6
         9JAfeX1H9xi/S+sh25LGdgA9FtjHrDu54B3hyFpfX8PoR/kszinqYSm4wqW3FiQnboX1
         8Lrw==
X-Gm-Message-State: AAQBX9f8Bbx13cr/cCWLANjuKXkiH/zHH1+PlbXSdm1G5m782ZrRkzgQ
        Xre6XVQNShJf2UD4yHjfFd9IJ0c1TUNXD6mQz8o=
X-Google-Smtp-Source: AKy350bWXBjFeQGW9xD4J6ukpl+/q6mORo5ybbc31ebqc0qMaIRU7nyAX8HtoORLZMP4XMiSRefLuiBa4cRA7bNPPyM=
X-Received: by 2002:a05:620a:4720:b0:745:f645:a4ab with SMTP id
 bs32-20020a05620a472000b00745f645a4abmr1763000qkb.2.1680767025486; Thu, 06
 Apr 2023 00:43:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f284:0:b0:5dc:6cbc:32ae with HTTP; Thu, 6 Apr 2023
 00:43:45 -0700 (PDT)
Reply-To: americabnkcapitalloan@outlook.com
From:   Amadeo Giannini <david.gao2honeywell@gmail.com>
Date:   Thu, 6 Apr 2023 08:43:45 +0100
Message-ID: <CABdiy2-9tPS-NND1aMYEmaNbpQPhbrm8bGBbV5Kq-rwuYvMeig@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you need a loan, how much do you need? I offer long and short term
loan between 1 - 20 years time.

Amadeo Giannini.
