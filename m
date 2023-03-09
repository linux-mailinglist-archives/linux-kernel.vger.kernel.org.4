Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466046B28EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCIPdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCIPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:33:45 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CBA60412
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:33:44 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id y184so1920079oiy.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678376024;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3tQa/xAjjFjMbYTIPvabJVdNLC/DkLFMMTZCH3qWNU=;
        b=QvvjaWIdAfx22b4gtDbxKJOEDuu0hJBZiTLRpbKqqokYRD875D9GSSYvzHE18div4d
         gboZy1ImNAeNwLhx0ws/IpCNbHMvtCjJnAJ5yY+vCe/9gZeXIAU6tLkqKhXCSqEXeRNz
         VDdGYf9QM+yP2wDA7sC/wWdDzK/Hy+7QJSnG8YVp8UvPN+cSnvtwvHy26ynSjWb1xNYK
         JKrUBe0eJE1TUZvVgj1QXk45ZaiSCozQAqUEMJ3DtkJJ5AKfkU8bB8927bFgq+QswE8Y
         v4y+0V/y0oRNdJgbwMk/He+44k1lvtDkqJVRpPfRLuDBp4coGXu8+c9gO3qrPdzDmu+l
         5MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678376024;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3tQa/xAjjFjMbYTIPvabJVdNLC/DkLFMMTZCH3qWNU=;
        b=DSH8pjifelk7laRm88ThsHiGB2BsyxPox5vkN87COFDw4te3urmtIOMOOQ5nGMgDbc
         82yNeNayYGvuSl4Cw94EsA5XLjByH5AuEzSQCmu9LgkhcbwFICbin2bM0wAu0liEizYU
         9d3UtJbaoaDFZErDpgJwnJWKeNx1hxmAOH/0HAizDl2zlAM5sr9AcPv1+0dVcYsmmVqR
         dCmJbHUFcSmz6JGTsLuUc6YDw2UYMe3zT5X2/5j0Cw5mLI1BZBhF/w/nlza9u/uwGbQq
         GvHg8pC/oZq6ErSfAzs4xXkfSVEKz3e0mYvqFe5NecYiZcUh6c/KQjbhr5TkeJ2FoO0S
         MFUA==
X-Gm-Message-State: AO0yUKX8lh9IKmKqHqxyEDNlh4aEtODW+alRQK+BIxj59bRUl16PjQ/Y
        7UVsSKW8a7VeuntILWEBYE5cSqtQ+ndjrNZs9Dc=
X-Google-Smtp-Source: AK7set9FvxyzRgLXZiMhQwV2U4jeU2LvMtifje2N7sBN9kpV64ohjU8fFGuqGy7dIhHwova76QIH9zyJHeP8GiJBQT0=
X-Received: by 2002:a05:6808:9b1:b0:384:efe:729a with SMTP id
 e17-20020a05680809b100b003840efe729amr7554284oig.2.1678376023726; Thu, 09 Mar
 2023 07:33:43 -0800 (PST)
MIME-Version: 1.0
Sender: innocentwokocha4u@gmail.com
Received: by 2002:a05:6359:382:b0:105:28d5:ccea with HTTP; Thu, 9 Mar 2023
 07:33:42 -0800 (PST)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Thu, 9 Mar 2023 21:03:42 +0530
X-Google-Sender-Auth: 2zKXB7SevHT00c_-mfub0A5bLlw
Message-ID: <CAEyv66nUd8+MNzVHsWLGMwiJ566a5_79OvCda78YDkYk8mR6LQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Ms Elena Tudorie, I have a important  business  to discuss with you,
Thanks for your time and  Attention.
Regards.
Mrs.Elena Tudorie
