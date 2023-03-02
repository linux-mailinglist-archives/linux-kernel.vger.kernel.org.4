Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD56A834D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 14:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCBNQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 08:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCBNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 08:15:59 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11DDC65D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 05:15:57 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g73-20020a9d12cf000000b006943a7df072so1246715otg.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 05:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bbK+hoHHhnXmjneGN7RNvn3pH0i9qY9kxV+nXEJ8Qm0=;
        b=GrWH42lFPa/dq70qyaVUW/QdX3dlACoa9Yn+MSmmKiAn4HRhCgir4zbeMfJppMR2ji
         cH/IUbek0MpSfGeFstjGqYlrQx0OD8skUAbgXZdzqWNIEqXPkJ3ErqAt0/7BGNlH+rYI
         4liO8MCoyMMqYzil+PZziibp9SflTjz7U7BRrslpUR16XTEEAzvcsqD6nxm3JN5azPKn
         IMm/r7NkkaB7MTdqEwzuk4JoNQo2Rr69VGPeizvu02H2eZKKxHysT38qCsbBxPQBAOdl
         eo+bL/stCZQGA/+mhI9oVPNKp5fmUHwHclHLRwBEADCxbbRXjyxRmJ0QzDIH+6F62WmG
         iziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbK+hoHHhnXmjneGN7RNvn3pH0i9qY9kxV+nXEJ8Qm0=;
        b=dd2Rt7fqhT07ZFjfcEH9v4iusz2VP9/smsoUFTXKHq0duSi43QRWrWi1xUKcWpb1U6
         Vo+J81nHcqyf0dVGzhf3VLrI7jhTw4x8UvjOfOGHDdIvV0uvCk5bmLV/XguYm3po4yey
         YnDZxjua8JbTJUkhp2f7usGgRkwg3nZHmzfHfmTn0C1JUhI2uS24h7dt0fpaeb1RKhb7
         RVaA8WTKUVkbcXYudN8xcwbMtYFdX+LJNbF49DFAVkukdNa1LLunYqe9HYvrZ8apbQLj
         RQy8lvbTAvzqb45u/gVcQETR2i1aUPC3aqPLWtNgfDH570SqwWbVv9K6rDQxoVEiHHR9
         YFOg==
X-Gm-Message-State: AO0yUKWN4IxqnbvokqiYOXn7oqwwDkLyf7hkNYfRivgnR2Abo5LTVJUM
        sosiJtrn3O/OcJ+NQ32FVvSaT6Hldva4nRXXmZ0=
X-Google-Smtp-Source: AK7set+L3eioLWIkgI2VJHUXSJOu4ExO9a2QUMjl2E1WJQTnrSC1cvNpM1pSOpYTeq94OUZD6fOdF8/7WoEW6pvpgW0=
X-Received: by 2002:a9d:806:0:b0:68b:d7a3:8027 with SMTP id
 6-20020a9d0806000000b0068bd7a38027mr3414635oty.0.1677762957280; Thu, 02 Mar
 2023 05:15:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:e485:b0:101:3194:b4ce with HTTP; Thu, 2 Mar 2023
 05:15:56 -0800 (PST)
From:   "Adel A.A" <aaadela44@gmail.com>
Date:   Thu, 2 Mar 2023 05:15:56 -0800
Message-ID: <CAOBhN-JcvNFbmA1v=_UKq9ofKqD8fEANdgPV3n8qujRzJvx0eA@mail.gmail.com>
Subject: We finance viable projects only
To:     undisclosed-recipients:;
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

Attention: Sir

Our Company is willing, ready to help you grow your network and offer
you Loan funds to complete and fund your existing Projects. We can
send you our Company Terms and Condition after review of your project
plan and  executive summary of your project, if you are serious and
Interested contact us for further Information:


Best Regards

Dr. Adel Aldoseri
