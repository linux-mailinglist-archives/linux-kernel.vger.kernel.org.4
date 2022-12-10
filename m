Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353F5648EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLJM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLJM3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:29:20 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E616141
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:29:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f3so5282952pgc.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=HTAMY76oM0jSprJj0oRtfr0VpMZfYZFHc+qzcnQrYiZI9zIq41IVegC6p5Giqe73ag
         wlFsxyr5kUBZtri+JHmpigq8OMiKpXPm/AHcxWfK8PUYsl4JQN5qvte+6l/d8T9D07EJ
         LLwoksrmq3xe4+kMWa9cVV2W+MAe0DFIwvn1t7jLwYzCqoacCocCRe7MYGZKnF0Skfz7
         MRo1EFo1dAHJnTldsW9AdwOTASg6DKk0sPSPaFZgrS6AmaSpcwqZN+vqkWb//vNsYaqb
         b1BSnIf78qBhYgwDKovovwLR09EWcOO7KAo4BWAaVyb82HlXJ1hPICvFFNylUWAXqoPG
         Zj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=TC42t2bhLiFYFyIs+LsQ2sVWexWPmcijJAdNb/2O6RcSdQ3crNqv9LPJz52dmsNQAy
         1E+bO8+kI624dMkb6hYSPRiFT8CJAAj6vUCJPh5Xc5bJI78Vg+ae6suaJ95hKD4keCdd
         t5hyswGaO9GAvsJmnL4JAbhB4Ae7Ij8RdnqyPbNPmz8s/gJnNHAuosS1q+LiybRE1Qdv
         tHdj2y+izzVh1iDr6A7QUp2nFmc/OVJrOq+IT3UeZrsnx9VtySGx/+2D99oNv2ABukb/
         v4xkcArPQxztx3yPr3zOhEwaVhvIkU5GRxEVIGyb0KCBcQv6ickxHmAi3TXbQj8HDEtW
         NrSA==
X-Gm-Message-State: ANoB5pl87sFL/Zd98FaQUl4xUmlSKNIMCpps/GcrxYKqf/sFwYUAfKuC
        TG4dY62EjfkUKKRme7sVM1VoU1nKCRFW7yUzwkk=
X-Google-Smtp-Source: AA0mqf40TQR/vXKSzUkpZAeWE4ubplSwqFtJXq0qqUsxNSZhD7UYQTyYGZBXxPU/lMHJpUrwiISJdmV2VZa6lkEWv2E=
X-Received: by 2002:aa7:8744:0:b0:576:af2d:4c4d with SMTP id
 g4-20020aa78744000000b00576af2d4c4dmr23392462pfo.69.1670675359481; Sat, 10
 Dec 2022 04:29:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:24a3:b0:47:9976:2037 with HTTP; Sat, 10 Dec 2022
 04:29:19 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <gimenezmarco201@gmail.com>
Date:   Sat, 10 Dec 2022 13:29:19 +0100
Message-ID: <CA+cx=QkkiQP3+FFUyXMz01fzwsWM58NHCTjVO=Dkh8HSZyTMxg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

I have an important message which i want to discuss with you.

Your Faithfully

Mrs Can Yeu
