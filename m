Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33D267FB41
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjA1V4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjA1V4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:56:01 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E7B766
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:56:00 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so22439584ejc.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rgw+NO2R+Zgydz7zku2izM3aiVrrXRNPIDm+P8aio1M=;
        b=Uu9h0Y1gsGDFMEr7Z1n+apnzofsUHIlqVSCFZI3+v7wqk6pnVpnHYxbI1oNizZUs/Y
         BcEXM4wikHXml8PI3q+6X/cmD6ayXvC+aPpxWXuMrZKpGFjF4VmgewBBj4llWPkdm8GR
         cgMPsukmDhjUarobOl/20HHUIv0CMY/G0GEoauw93Yq2CavdC0iUwrRZO7WyYK62aiYQ
         RPqUWHHR8uMQcIUd6LzOzkAiIKrWx8vxvM+HlWQWbs9BBFqGeWNaYLiqd4uaVRB90WBb
         NQsSkpGNxsNUzZArC+e9PiXScNalseLZiWOfHyxdujUv9CPGN+tioD5Q21hYCBonM03Q
         WPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgw+NO2R+Zgydz7zku2izM3aiVrrXRNPIDm+P8aio1M=;
        b=bI8vIPFZcr8OvlnW+z9xymzi6zJiZ9z9SJv89eh3E6tPONNePfYBCoXHv1IVmQzRRe
         3ciTIoPj5J+SNHday0Exi890AiRTsKZ0GX+l2RTDYo5TTgQPcs6l4p9Yh/OkqlG0GWxs
         yQXtPce6UzziWPHxOpBKx62rnRp9LC3AGKXwI0MQq8i/Iqo7MxaYDZk/ppWdv8YUdJhD
         DyDsBLxVyWU6h7GKiBgUixeTcPY3AFwPC1lD5lT54iRntE8CZM1Syx36peQwh/xUxK5u
         LoDpk9AIGktrqqj1wUYrBuI6EsYVLHyqyFVZI5qydTrBzOxmCcQhQD6OAyblD+8goEKl
         hqzg==
X-Gm-Message-State: AFqh2kpXFDcu/MxKC2/1sZuc5Z+pkViO3cFgGIE/GWL7ZHGur/MumALN
        Qslq5suO+ZgnB+b0fiwXVj32KjpH0L6gnczpSrE=
X-Google-Smtp-Source: AMrXdXt8HT9BtZK50Ca44tMOz5jsLw6C+8FeiaxyPMI6ZsuO8HsvETOQb2cXxzHlhjz8C6xTTGIhBBiLsAariQbFpBo=
X-Received: by 2002:a17:906:c0e:b0:86c:f643:89c8 with SMTP id
 s14-20020a1709060c0e00b0086cf64389c8mr5731624ejf.131.1674942958126; Sat, 28
 Jan 2023 13:55:58 -0800 (PST)
MIME-Version: 1.0
Reply-To: deerr00stefan@gmail.com
Sender: akgazshak@gmail.com
Received: by 2002:a50:78cd:0:b0:1e9:970d:ef7c with HTTP; Sat, 28 Jan 2023
 13:55:56 -0800 (PST)
From:   Stef <daarr00stefan@gmail.com>
Date:   Sat, 28 Jan 2023 22:55:56 +0100
X-Google-Sender-Auth: Sla43l8QMGLSa4uhIgdmbSwdqmo
Message-ID: <CAOhRj8P985Q8eXXYiRkZiX2UzSFZW9ANhip3HqSrk6LYiaORHw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkknZMKgYXBwcmVjaWF0ZcKgYcKgbXV0dWFswqBmcmllbmRzaGlwLsKgSSdtwqBTdGVm
LMKgd291bGTCoGxpa2XCoHRvwqBrbm93wqBtb3JlDQphYm91dMKgeW91LsKgScKgYmVsaWV2ZcKg
YcKgZGF5wqBpc8KgcXVpdGXCoGVub3VnaMKgdG/CoGdldMKgdG/CoGtub3fCoGHCoHN0cmFuZ2Vy
Lg0KU29ycnnCoGZvcsKgaW52YWRpbmfCoHlvdXLCoHByaXZhY3kNCg0KS2lzcw0KU3RlZg0K
