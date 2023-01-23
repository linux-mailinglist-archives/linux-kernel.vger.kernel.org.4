Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48666677F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjAWPQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjAWPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:15:46 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398CA29E37
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:22 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id d66so13173745vsd.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=Fafnhf05w77wTYl9NpflMn4nYNje3NCmamtAkp5tFi1Y4Ef2DtdDkRkqRZpa/ylmzA
         1xt+SNIu7pyYMMovbJex1eINAev6U81zUbV2OpOfeENJhTIx6D1XVcR2Nvujxan761rf
         6/mLEszgrRVNCwZBrILHITEvXP+9VLLzCHu/DY/ryOBsUcu2pbMJo7QVBqxvJZRKhsL6
         yQusB1IHWN+a6zmrijwsb1cqj4Cnk/YuKf0+HPE3CiCZeJgMdL8Ogd3nEjugGbYjV/HB
         n+ZwjET55Q+zkaWevgHq5GjcfTKXk4ocjW3FqSdJSJot/6vP1BKApTqYnG+Khhr5O68U
         Tnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=vBQt7fyuhRh419ZgVKCsD+sv+CDeSENloytVxgJCXG3TKHWw8jX6glzpSrjwGL3CZc
         p12lnJ4NWXbC/8eMSiLLVm/Q8j6haqjT9yB3t8FVB9U6hCPwzs1hKDcJup1C4HKJD9jy
         8D132vsjmBZfZJ0QgCGTXBvMyrRZL8DDEIIzeyzfcVWyB4CcD7sjlUjaOup516ToB6K4
         w+tBh/0RxPgp5EZGNXAmoFqQ+kUA29q/eduxHiFHfMRJ+yLq6FefRTTUpO4+G2fqiaD5
         fq/+TgGdIGQDRCdw63p8ZiAuPS6Zl1ZNIN5DqwvIpIhdMJ27aHTDwvAPiZIxy9s65t8Y
         LDQg==
X-Gm-Message-State: AFqh2kpbgPczr8295k4r/TtzkwHuXr2wxS12RglDDM2BqmtlaMQ7FKgn
        dzVzY5btz5VhT6kvek2WZQLgV8gv6BpTPzFOo8o=
X-Google-Smtp-Source: AMrXdXt4EAREOKQqpapqWmUMXMdsYL8TPJ5uzBpcPi54KbpOPdnVsiYF8BigrnG9iq9o1BW0IQnLO+QN5t5bvbNrSdo=
X-Received: by 2002:a67:eb10:0:b0:3c9:8cc2:dd04 with SMTP id
 a16-20020a67eb10000000b003c98cc2dd04mr3509457vso.73.1674486921265; Mon, 23
 Jan 2023 07:15:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:c00d:0:b0:38e:f7a3:7fdf with HTTP; Mon, 23 Jan 2023
 07:15:20 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Susan Bikram <igoniemerges021@gmail.com>
Date:   Mon, 23 Jan 2023 07:15:20 -0800
Message-ID: <CAPdPzj0o22-Z+CGdUXFHTzOCZ3QhUh-3d9DwMwvZM4sy6j-7CQ@mail.gmail.com>
Subject: Please can i have your attention
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

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
