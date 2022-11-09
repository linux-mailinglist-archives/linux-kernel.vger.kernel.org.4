Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFB6234D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiKIUq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiKIUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:46:26 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F347B19290
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:46:25 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id n85so134562yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K0xNGCYzLrBb3zN9j/dQ0hbxV9/TtIpbx9q6z9XkGXk=;
        b=RVnfGU6luer5Mo3sg0Zug2HftMuph+D5guDnBL0PCn21y9WKShxtR0pGMvoSz4a3y3
         3iQE5fL5N7hWjGeeLp9XpO+dViR1fFYukTMez2ITiPMUWr0tQ05pEs+MKU1egWIdJeNn
         rX5TXcvKrIZTutmeb2+X4/sU+MqIDfuxNmbTSKNEOaBlgWNY9AsurNNXw3/ppX4wC8tx
         ds59iBR4b/lxzG5UWy1gRDkT1DkDDHF6lCGTAOn1i1cWuNIUQmsX+1cenpWcpWrGt/VS
         ImH0WqtHQNDAOlqidu5VzJoqmXQ1wDaz2xQ8N3IloD5sV06CUvmYyuYteGBNBneDLugh
         NTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0xNGCYzLrBb3zN9j/dQ0hbxV9/TtIpbx9q6z9XkGXk=;
        b=5p0K6S+Rjokr6OqmGJM6VZd77GVnYF0df2ZWbwtwTiTYvO/0E8TBYYSEyeqv/C8XTR
         rzXTXFEsRvz/gW0CL0MBUxEgEEpTCSxsXpT++wrzjc08MvFYWiRtetAOEk6jUaXn0TbO
         JaNFgkTtVy4SlNoheXkrfL/gRBv6habSeui5/p06JqZ+MWDmzaeF/yZ4vWQQUcOKVxri
         qLC9J1YiaXWlYT0czdMLPZG3GHc/Njn3gaIHzO4iFi6O7w5nAjnhyDrw+QuVG4YBaI7m
         ZO5/Zup5OAIgTOY7v5YHl14z/q0xOdujecryOrq7gKI+cUUU8urYKokJkBSbirBmUes/
         jzmg==
X-Gm-Message-State: ACrzQf0eVocprFOr+nWnxPgfAV/1Om5logHzLvnaPBFPjJ0XEEWYphWO
        kEzZJQrY4eQ3dKYYfTPyr5+7lxpeF1iSW/UiOWwtB8lebzw=
X-Google-Smtp-Source: AMsMyM4rCZ0N9og7mZEABWgRdK6Z84GEjRv/PE9jfy3hf4RTtWOp5XUTGu0fNzZCJGV/W8D9gWGMElkblWeGdFe3SVY=
X-Received: by 2002:a25:73d6:0:b0:6cb:4010:f056 with SMTP id
 o205-20020a2573d6000000b006cb4010f056mr57770503ybc.428.1668026784906; Wed, 09
 Nov 2022 12:46:24 -0800 (PST)
MIME-Version: 1.0
From:   sindhu krishnan <sindhu.muthu25@gmail.com>
Date:   Thu, 10 Nov 2022 02:16:14 +0530
Message-ID: <CAAJ7f9BRoNJdFiH4YzyjDUtm50by3+9Ce_yiU7VE0_M9UHxdBg@mail.gmail.com>
Subject: Hw perf events are not supported in kernel 5.4.108 version
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to access performance counters of ARM processors on the
Broadcom/Technicolor SoC.
When running perf stat it shows that the Hardware performance counters
are not supported.
Also, perf list doesn't show any hardware event, only software ones.
I've compiled Linux with Yocto, kernel 5.4.108.
I'm using the below kernel configs:
CONFIG_HW_PERF_EVENTS=y
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y

I was able to get the hardware events with 4.9 version in the same target.
Please help me to understand why it doesn't work.

Thank you,
Sindhu
