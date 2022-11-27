Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1482639CA4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiK0Tz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK0Tz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:55:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F86DEE0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:55:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d1so13836673wrs.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=biw1utCmNyI+ef9futimPqL2qrgw3YwY9eWMD1oBQZg=;
        b=qMYzMqqfIqgY4S2qpJgRECqRibQyJEXtnkfhpekPyc9VX+v0x/mdNYr7RVQoS4nlnu
         8L0iW19/wK8UecTSm3jvKELw+nhP5B1lDx3EYKgef0X55jb2RC2Dj4EIdRB2XhtjSmkS
         FedFqdATyQiJkjH0f5rQsM7fNmXdUL/1FyKXR27ABSHhkQQgldRnf8Ys3+PPcsQn9mSu
         RPVZFd8xZVaWV0NY+vXS3SXHPtrvx3jtnUAQZlGsx4tRXlOf7ROkRB0ChcTvGtRg46vL
         LqvDaHAMOr7+W5q+GozuEp/7OrlHPb5kZdL6OFbaIvgE5YAWPshvWC0EUh6qRGXpGvRW
         JbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biw1utCmNyI+ef9futimPqL2qrgw3YwY9eWMD1oBQZg=;
        b=yYxKUdD0kvJfiTJA0mASUOmeLXx89OOUWW6ImF32diuF8Hq4eBsyxjoFYvk92dSizG
         bghuSctref+hSSq5b68QTFIJbTW25mqPk7MRszfLIyzp5WojtiKGCrW2MAR3v2GQZGIm
         tKy/K9bQFtlgsy5AczjvPIBeb63U+9gribxd9AJ01QMn9785NtjjITcGcuXSboL5rX4q
         op9lNN0SNeb0tNNeAR3CvsAdrGWysOcqghQrpQI8PigNDAfyGdOo6xVO9oqjFzNncRzg
         L+xhMUVjtixwTICiGmF/+jaejAHummhOXszGmFrOtdjYwBn+wdK1Z9W+lyr/xOXxUpYS
         epqQ==
X-Gm-Message-State: ANoB5pmcYHHuHFmqTmDE6us+dZhAR5ElBJ0AK5r/YBOAB9vlOir0smTo
        6j3XYqNKtbWM5kQ/fsTHmIAiWr4kgIMXrE/wY9Nbbp09thyiet0a
X-Google-Smtp-Source: AA0mqf7L0g8ekhIf94lyokcRVdwhhDWL73e4aWqJHuhTNuijm8zFy1mdF2EkljVg/8rVZw53H73vVt1DfJ56Db4lRCA=
X-Received: by 2002:a5d:620e:0:b0:241:e32f:8371 with SMTP id
 y14-20020a5d620e000000b00241e32f8371mr15984149wru.156.1669578955441; Sun, 27
 Nov 2022 11:55:55 -0800 (PST)
Received: from 332509754669 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Nov 2022 13:55:55 -0600
From:   HAROLD COOPER <haroldcooper810@gmail.com>
Mime-Version: 1.0
Date:   Sun, 27 Nov 2022 13:55:55 -0600
Message-ID: <CA+0JWip+xPBXw=pf9L_cCb86CQUPRHVEdOjrE8KxBmehBpqgGw@mail.gmail.com>
Subject: HARD HAT
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To whom it may concern,
I would like to order HARD HAT . I would be glad if you could email me
back with the types and pricing you carry at the moment .

Regards ,
Mr HAROLD COOPER
PH: 813 750 7707
