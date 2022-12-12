Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C88649F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiLLMqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiLLMqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:46:39 -0500
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A011C3A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:46:39 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-3b10392c064so144225407b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaQPhI8N4H6dyN/+L2S22G2Ev8to2HE/AsRBdgvtEyc=;
        b=kORaJQSEcYjMwiOBEgAbeAf6SoAF/BdJ1QQ6nE5Z9RcuYBuGm8pmLJjhxZjw8+sHzH
         AxvXN60J9fdjvqDm4dpnwi2MMY682tFDpABSuVxeL3U6ImLQCuET4Vl0QhVojgeo3Xsj
         DLkj7babFdWm27sE0Oep3xUaweG4D5Co+XtUGi4xNqV1dul66tXnWu2Bo6fYG62PFa4H
         xj3FNV8JUMAUpHeoFrmB0He+adItjPT2LwKbaue2OJrlRZkMCEknfnlf5NIkwifMiu1I
         PRoAPLH30wwzjEpB7nH8ZUbO5auzzdJsppJqKC1lMh+etlGmLI9ymcmeJF9gnYx15aB1
         Yl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaQPhI8N4H6dyN/+L2S22G2Ev8to2HE/AsRBdgvtEyc=;
        b=GXztg5K8mMd6tN2yFc0kHBwQe8ScFmLbSzwUt3ybJZ0LxUD3fNRGeirPiXFtCqdekj
         up61gGjEm8gKi4NL9akpwmn53nvcGjLpe7RHIkjqhmXvC2iO+J6XMzY79/nTHjkI9vt0
         8PD/0qrFdfvm36vmleFxzfJDbWuaaEDuYqTwqS1LSaIdpKQRJxCmeDYh0RxO75oO6y/C
         ptVTSAyqNJ0FkVsE8zMaKvEsMtHjo4j3z2h0t3cbiO2myVf3N2T1c/3i6qtVPaSaRmku
         XNgTUJcjbiNikmJ69J9el5yPztgC/NtwDAytp7R4fLrIq7V2MkFBjFFELo7vslhaVWtS
         oXHA==
X-Gm-Message-State: ANoB5pnsmrQ8v24bMNTIZMuf94nhMcM30tw4WiCeZU4iytnpocqn34OG
        /jr4eKSTOJXvp+6vNO8FK0UFg7dH4D7FRV7yIZc=
X-Google-Smtp-Source: AA0mqf7azZSR3fkZxGUKlzHNReV15Nh6Buyr/2Q/lxksgFv5TRh7Aga2UybwT52+emU2iAYjikob/lxvICFKUo4AtUw=
X-Received: by 2002:a81:574f:0:b0:3cf:57d1:e770 with SMTP id
 l76-20020a81574f000000b003cf57d1e770mr40272658ywb.289.1670849198453; Mon, 12
 Dec 2022 04:46:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:7983:b0:3df:5688:6324 with HTTP; Mon, 12 Dec 2022
 04:46:38 -0800 (PST)
Reply-To: mdm223664@gmail.com
From:   "Dr. Woo Nam" <woonam115@gmail.com>
Date:   Mon, 12 Dec 2022 04:46:38 -0800
Message-ID: <CAGdtzSbJYXAF_fKgmoAp0do=1AibZUFAgnjKt-CZR7c+=PbrNA@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
Hello,
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Best regards
Dr. Woo Nam
