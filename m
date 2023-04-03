Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FED6D545F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjDCWCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjDCWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:02:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B035A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:02:21 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id x3so122960982edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680559339;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F17wSJgPs6oA/SZ+cp00EmNuMKwbhVZp0H1mJrng124=;
        b=H+iTaq4dDU2HeTeabqhjxK2OI5vjtCFkdHHMFMK4HsTFmYt3KCnsWXHeAqxamujYTz
         zm+WlIe7WZARnGw8LWsoK71YHGIJ4WARr3DC5dpBprn1si2gbI1S1XWRPIMnX14NqwNR
         YBRYlVV0nGNjeZzWn1HFFq2xOzQCpabAKbS3IoiEegLJRd4i+ZWyAoeObeGd7NEx5OIB
         fBAUSPH3VyJb+UzwbIJlFFcUWBBoNCm/isZhIp2LU/fRPlYZ5d+fHp1baEi0eOXD4ifk
         iqNzlYaFdq7rIAkPxF8OzQ3c5FZZn1+KaQ62CeGhPzK8BPKhxrOmX8XE4EfyKxeAjp/g
         QUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680559339;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F17wSJgPs6oA/SZ+cp00EmNuMKwbhVZp0H1mJrng124=;
        b=S8s+IO6e4FUtkVLtYCjedvmbF2+Rka53EcbPCV3EIrz8e4Phba03b4wAEoNdJQ/34J
         n02YMSBXf/YPGx/t3QFtot3SBNUp58boyAaTcd8tdjsC78JxvVmposT0iVTsVMSQoPPZ
         r57qK7owB/K196R+SyVwCAqc3wHVcNEqhC8cFyeC+YPT0KZoseP8KjPI2lFeD5DkiLFX
         +NwaJmOGIlvJSGkRvE7sDLvZZvqLjoBmNe8HuOIrzRxOe2tU6ExJ4V0bJ0/tg4Lx6Mwg
         E5F7aCSwT0aBr0v5Fl380Z7WfrApkjd8wwTDwrS6my0ZVLmKpHeT7TVisD3W2SrqoJR8
         v6zA==
X-Gm-Message-State: AAQBX9dbc0XUqxLDL7NYO4PRGYDh0nUBMbuswg3OTJZje+z8ryio6pxH
        CFBmdiy+8kqmiedYYLMeErUWkRyJXWdMcgEbjrA=
X-Google-Smtp-Source: AKy350ZevLGrv8v5GJbwfU/0Lgl1JOYpf20geZ5x9DQPweJLcbmLwqmm5bawXquUaZ2vt/eOc8BgY6VcqpPvZv0Nj94=
X-Received: by 2002:a17:906:3e4f:b0:93f:faf:6375 with SMTP id
 t15-20020a1709063e4f00b0093f0faf6375mr90160eji.8.1680559339551; Mon, 03 Apr
 2023 15:02:19 -0700 (PDT)
MIME-Version: 1.0
From:   Sara Jack <certifiedbusinessdata0@gmail.com>
Date:   Mon, 3 Apr 2023 17:02:07 -0500
Message-ID: <CAAM1_GJbr=EmHUgzeQGsxG26K3wsz6oERF=ot-RqyFLcfeiCHQ@mail.gmail.com>
Subject: RE: RSA Conference North Expo & South Expo Attendees List- 2023
To:     Sara Jack <certifiedbusinessdata0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,FILL_THIS_FORM_LONG,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are following up to confirm if you are interested in acquiring the
Visitors/Attendees list of The RSA Conference?

RSA Conference
Number of Attendees: 40,243
Cost: $ 1,826

Each Contact of the Attendees list contains: Contact Name, Email
Address, Company Name, URL/Website, Phone No, and Title/Designation.

Interested? Email me back; I would love to provide more information on the list.

Kind Regards,
Sara Jack
