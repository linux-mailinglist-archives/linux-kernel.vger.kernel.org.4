Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D576C1DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjCTRXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjCTRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:22:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F095E1BD3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:18:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so49706273edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679332726;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=Od6bn6JKfVjuS3o9NMP3fUbFKIUAf0xbnjXyDAnA1BZo6Bw5rzCgepepdwmBJLHrHP
         1QkkU3DH1WDodO07Rqq/csez5W1dM2cm+aptAs7A6mMohp8RYUD6jOK1JFiZT+NO+NtB
         IijrMGEOKW7olnbq+1lNyrQN9hm86yw1YOABfYegvRCZffTwZizjUV/fsMmvbXl43zT9
         G/ZLZpSQgDbKd931JW17uq4fbfwo/LYHUAKq8lYm0rQhVcfhexyFOKcA5z/gQSd/ZjP7
         d4c4H1HG/rm7ICSOC6cnYg4sf004srDYajooWGk6f4EVJbsLzL410wD7bm4JkGSYVDZD
         vdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332726;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=mQ2n2QBxbjimHIOY4ZA8GqRy+pupFHjXW0XIqWMmU18vfSazIY+PYzfdXx6GzVB8e/
         s7GDclxuRaV2Wz0SpSdaDTq6y5orcJlUBneic8Z1QRPS5lDNVJiia3TQlMxBwS0dKO7B
         wcb76QnO2qeUDkFZJ79SVzViOCYqCKyq3HFVfV2uRWFtwRJ8VZHdo4s7M6WUJml3AVRX
         E2RerfjfO76THhZGN7tTO3IosaDC6m9QjWYOIpSZjU1enm8P5aJIAj1qUbPnqn7zbgd4
         BVl+WhZdotLBVZgpT1G2JZPhXXZAIjgzx7zvXvUeeb1E+1yAiWvXaVvPkS40uSWRRZX2
         uX2A==
X-Gm-Message-State: AO0yUKWaokgqjgpQw0zWR5LZ7vj9xpWEgCZtUWDTZc0aI8zY9U3SGtIL
        opttui1R9B4Sz2saDZAiXfqkUKrAX9RdzW5D3Jo=
X-Google-Smtp-Source: AK7set/bBAQxq6hs36eRSLOuJyCH3eLTXutMcZk+jQqh8IVgA6rAsCBSs2T6nZd9laXg4SGG6As3Ts/c5yL44P/HWpA=
X-Received: by 2002:a50:c389:0:b0:4fa:3c0b:74c with SMTP id
 h9-20020a50c389000000b004fa3c0b074cmr169725edf.4.1679332726108; Mon, 20 Mar
 2023 10:18:46 -0700 (PDT)
MIME-Version: 1.0
Sender: prafullpanwar9174776568@gmail.com
Received: by 2002:a05:6f02:a25e:b0:46:2cca:c3f7 with HTTP; Mon, 20 Mar 2023
 10:18:45 -0700 (PDT)
From:   AhilLia Lialia <mrsliaahil070@gmail.com>
Date:   Mon, 20 Mar 2023 05:18:45 -1200
X-Google-Sender-Auth: 4tt-fjFcpScGQlavea6Wfe_ZJvI
Message-ID: <CAAyD0rsxzySL6aFkBGvLkUdktPCcXRX13K6B2d9X7Sksn8dUqw@mail.gmail.com>
Subject: Hello, I need your assistance in this very matter
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


