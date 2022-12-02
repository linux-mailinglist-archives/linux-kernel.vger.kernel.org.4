Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F48640B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiLBQ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiLBQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:59:14 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16F218E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:57:50 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id t10so5024405vsa.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=XUKr7aG4iryEpRDlsmzdnRxpmjav/orec/K7FGHxjHjKcNq6MFntb3wP2EEzbx7fsa
         OKWfH7W5U0qoUgSj+UoLAVmJYjYUa4bPdAqJ4wbCkOIt5bUdwS8oCZdNNmlpkGCyvqTj
         CpGnXJlipcf/MSZM2JsV42r2KddeZhbeCmDEM1Y46tuJSepZLhbzGPyYiYEkmL5qWlxY
         bKcBQk4H/gmMjNAtFyiZNdekp+jk5PuAiGotSRkLO1n9FalbKCeTU+o4hdLj4R08rvNc
         /2ibOMIzv5LMTomnGkVMRMOa2USEz6VDxVj/I2aO4m/HAwT+PfGPd/ran+KlssSHZUnH
         f3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=qCGUombXxmV/UJwv6UkfxlIGtRf5ad9QDhITlo7HSE1Uamd8bG30m+6kOOcr3OIS4P
         aQoLuSpuGgx0HNUMWeXl/UFTxxsvub3CwvUR6BzyuxyibAMDqx6yiXRNPj8BrndDJRmQ
         wcVocS6Jf0VhXGYZhoAjWzQ7QlDVVEBRgpXZf7l2iaGJ/Fi4IuxNj52TjA3+0JIkBFjT
         f70uuMQUWHPVlKXM0S6219DvouWcghyap1uzocga0iA8eNQ1AOioutI8PGcklxAMCgTc
         /KcXlffekdvp/jTsaCbtQhyFYWeLrjC0iyw7MwTR9IkrlpttMaM7FlRsuMSBcQHPo2py
         5jsQ==
X-Gm-Message-State: ANoB5plg0iKoYaIQKA13s42bJVlzZf2Q8N3dmKitmdgwu4UtzNMD4wcw
        wjOioQON+PfqA4QBc8Is1ZFw8yIT3Hq0G8aQ81w=
X-Google-Smtp-Source: AA0mqf7NYvJ2EEoWqFkvF+4M8ffW7tUkfEmzlNxrwBNQ4+IrEYpZuWanGKniLyL9+PVr3Vwn+mTNcb/udFYCXg+WBXU=
X-Received: by 2002:a67:eec3:0:b0:3ac:4693:4d66 with SMTP id
 o3-20020a67eec3000000b003ac46934d66mr36035871vsp.44.1670000269902; Fri, 02
 Dec 2022 08:57:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:36f8:0:0:0:0:0 with HTTP; Fri, 2 Dec 2022 08:57:49 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <carterwilson58h@gmail.com>
Date:   Fri, 2 Dec 2022 17:57:49 +0100
Message-ID: <CAE+QU4wm9sqaT5aYofJXov4AOZBTC1tepPrsVP2GqKnYVhQmXg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
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
