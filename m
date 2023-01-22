Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30135676C0D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 11:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjAVKSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 05:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAVKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 05:18:11 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85D1E9F9;
        Sun, 22 Jan 2023 02:18:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y11so11360461edd.6;
        Sun, 22 Jan 2023 02:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B9kTiTN/nX8gSHban6Gq3NsQV1tXbOVpMBERwaB1WBU=;
        b=ZlSSwqijFDoAvivGb/z+zh56t2sjsURVxmocqDOa7BkiJMmMQA0iF8/N+vmRT/CM6Q
         yHoqHwEoCURqJF1Wn3mlihqciUzTt5N910KM77pTyL+8xsZURoPCM41zHtHxP5h+Wp5H
         CD6OkQnhqnq/h+IWyeY7LxCLLjCraBSYI1DpBAOtzEUsAL5HlilAuZ/JPb5XkNfAE/Iv
         el34XHn+tgtMgsLiIb1q+ZIkY8rfXij9b14UFKqyykUrkBinvEaA6V1lj9tRJn2XBY5K
         Glc/vvghZ28QjofjePJteTTZaWIZh7ZfL2XfI9RQE4s0c/udxZED9jyR+7N3nZ9I13sD
         F3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9kTiTN/nX8gSHban6Gq3NsQV1tXbOVpMBERwaB1WBU=;
        b=lMMMeSv5A7aWk8AqD7pOIwz4uWZFxtEefWgd/9ypSxEzwubh35q2UJoMG+cG5MUk/i
         N/epRptJrFbv5mQYTcGlo89BLqpqKfYF4B9FVLHZOk9WFMU+1rpwQivevbzx2DOmONZS
         6BoyqaGFNRlrrG1hcM46VIdaM5lLKxXJtyOCzhI7rBC6l4XulKq40fnVrUEE5vj31M9a
         gpDh/XwUtrr/x4BOFOWnU9j/01Ho3J5mC1kk08CuuUe3uZRmCA5KoJWgh+zc4JNYgMNg
         nxf+KdlFuFlcU7HpBPbsJa0PTVBpoHtD3HjBhH5TgdrlPeZXSfIbpJr6adr5yPc5iZzY
         XTVA==
X-Gm-Message-State: AFqh2kqFc+3RrkQtnQRT2i9ED347xb4+RhEmYnRzqfOLgxBtg/ktHCHn
        I1miJGJKJS0Cegj3ldseMds=
X-Google-Smtp-Source: AMrXdXvTeMp+DXPhTLoWwggwGcze+kSCG8bIpc2EKHAlBJ8KM+2+vTz3AMnmOFZEegbmzZQpFPRjIA==
X-Received: by 2002:aa7:d818:0:b0:49e:6e34:c359 with SMTP id v24-20020aa7d818000000b0049e6e34c359mr11656320edq.21.1674382686020;
        Sun, 22 Jan 2023 02:18:06 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7cd52000000b0047eeaae9558sm11955783edw.60.2023.01.22.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 02:18:05 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 8479EBE2EE8; Sun, 22 Jan 2023 11:18:04 +0100 (CET)
Date:   Sun, 22 Jan 2023 11:18:04 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: amd_pcm module not autoloading on Thinkpad X13 Gen 2a
Message-ID: <Y80NXKyaj25CtSBt@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

A user in Debian reported in contect of debugging a suspend issue on
the laptop, in s0ix mode, that the amd_pmc module is not autoloading.
Context in
https://gitlab.freedesktop.org/drm/amd/-/issues/2357#note_1730880 and
https://bugs.debian.org/1029356 .

What would be helpful here to provide to investigate the issue on why
amd_pmc module is not autoloading?

Regards,
Salvatore
