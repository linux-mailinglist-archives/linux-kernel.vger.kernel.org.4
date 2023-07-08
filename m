Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975574BC6E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 08:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjGHGtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 02:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGHGtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 02:49:14 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C381FEE;
        Fri,  7 Jul 2023 23:49:14 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-56fff21c2ebso32211797b3.3;
        Fri, 07 Jul 2023 23:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688798953; x=1691390953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhDYRPAnWtP4afL9YE9AQDbWS73jCYbg75eIeWdN/J4=;
        b=dq/LBJ2idRI3N9zXzeN6u/bqeED+hF558rz85ZMvmAuopaWlBqzj1c2ayGYJgSC/6d
         oo1SPG2l/wrEfDjCKo/38U6/9oC4kONsHrP3CVLP4XcbwaTzeeiHlNlpPPUkYk3SMgNv
         r8IRdQJ5o/ywpQme0gAmEYjXBdCpT0/GsWxjKQJksbqNvQ6RWMtisLJmep7+FZep9l45
         OV8PzklsEJY9qb4zyZXCbmEeaqtGfHYkIaUrb728dY8E8HJ5mbDz0z9jHbPdRE7GWTDj
         IsWfOcVDM5w4Je1OAX3jfrA4IH0Bgk0uroX5WC+NFtWTubI3TlDtR8pBp1wcZIIPTskY
         0KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688798953; x=1691390953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhDYRPAnWtP4afL9YE9AQDbWS73jCYbg75eIeWdN/J4=;
        b=UoMyUhGpRaApNjL5YO1zsTbyW065YAdG9rUte+9wZPmP39PG5jv3omAfQ7VT9enPIi
         mMkM6RiBkPSwzgIm4WWzYNB4EjCMsYJNsGUIcpUnLp810j+0zJfGw5v8sMq1q1DXSWSL
         xyU0BO0haCtYKef4nBF+pp/7TPklLz3+42no6jUrbtZSLDfPy0z2w4ToAhD+8isWOmPp
         QOxeB2zsuQEle9FBwKQf8nX20Q2b7uP4CYDmow6IfjgCCVyriJqRBtem5HDhWIcXz90V
         MuWFtYoP08j28RIq5VvHJl6JqGA7vPp2B1OOSSvIvdi83XAlEAvr72OuYi1ZcRqd/TN0
         2s8w==
X-Gm-Message-State: ABy/qLaoWNkXdOjqW8zpcf62NsSuo/t0/Z+1NalZ29mxtkcFoK18+IIV
        CuMJci4JoUwOOt6ghY7CtUWDgjlhrvcYoFQq
X-Google-Smtp-Source: APBJJlHZ5OBvQlf9tUZQdDYG6c1ETsclWCZH3f1yMNgx5QJbE4S/RaUX7JUa+wpayhNywkEQ0h1MKg==
X-Received: by 2002:a0d:d6ca:0:b0:577:16f7:91d9 with SMTP id y193-20020a0dd6ca000000b0057716f791d9mr7480114ywd.12.1688798953257;
        Fri, 07 Jul 2023 23:49:13 -0700 (PDT)
Received: from localhost.localdomain ([221.231.171.18])
        by smtp.gmail.com with ESMTPSA id 24-20020a17090a035800b0025be7b69d73sm2712272pjf.12.2023.07.07.23.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 23:49:12 -0700 (PDT)
From:   pinkperfect <pinkperfect2021@gmail.com>
To:     pinkperfect2021@gmail.com
Cc:     amitkarwar@gmail.com, ganapathi017@gmail.com,
        huxinming820@gmail.com, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        sharvari.harisangam@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: Fix memcpy oobs in mwifiex_set_encode
Date:   Sat,  8 Jul 2023 06:48:30 +0000
Message-Id: <20230708064830.2380766-1-pinkperfect2021@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230706020751.859773-1-pinkperfect2021@gmail.com>
References: <20230706020751.859773-1-pinkperfect2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is false alert, please ignore it. Thanks!
