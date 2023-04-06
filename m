Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34DA6D9EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbjDFRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjDFRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:35:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D66A255
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:34:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so43577952pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680802493; x=1683394493;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=RMPUqv5KZPwTDBBasNpo3QIJEAhggobF0fRqa8v7TU3KNKgLuuvWBienwxYzxIoFuj
         YxkMr87eJ0LbUj9Fj1QssxKwI44NjHkhURj+H8Hp5IEJI1xDrLuwOkICk95IQFw59udr
         ovmSGZ7YirIRomokkIEg21aI67yEj60s3vBsGJoOpM7yP71S2wAV4Ko0m2gUkQ8pspS6
         mSdjP6d4Ad4UWN1FxXURw5siqjkHCzn2r2vbPawn+sgjpIYgWRb7vzmXJHdGKiMLYuqL
         8uwi38ryk4AEdBFR/DCDhR+NJUJPNNH35OSClEZD+n3DtTcZmvPYuwvDqLtRcWH9rd70
         lXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802493; x=1683394493;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=AXUoZ9cqo/JQiXmSrkX8S+9BziyrD+M7IY5/Ph3P/DQ07H8uQabYM8uLzKRwjr0dBK
         lq96BRnYzZ8f7Xvx+sca57qa4MQAlLaY/bK0wFwYx2Xv+/MkZ/05m4SeaGAKTCQi2B0S
         jAPvWq7YAGc7jLQOjCFBYN/VYH463wdFtkgbNCij71WtPjHpLhpZxxqJ4vqUNAEoV/tm
         M8TMEIxTCPjHwzSm11uR/pHu4Y48OxAKwXTiV0iPM2jkvisbSgEGe15S/P5MihU9kvvG
         jOEbjJTD6Vvj6/AOVckCEbnTGEnoJGj1YckiAH6LP9CvsuUShvvNHarIikzf0WO+znEc
         8rdw==
X-Gm-Message-State: AAQBX9fZIbf3Rosdzq2O9nZQPpRZF0eQuEk478ekbIxTAfgkYNG45XbI
        V/2OQrWk8+PmP98E/36V/Dy81KIYPWacXLpdNc4=
X-Google-Smtp-Source: AKy350Yq+79MPK64XI70ZeCjqDO5bw2Nu+P2ByzIDn52AM8QGTdDUkLSFC239MVYmcXrSNoTlpTJqONonz2TqmArMoI=
X-Received: by 2002:a17:902:eac9:b0:1a0:5402:b17f with SMTP id
 p9-20020a170902eac900b001a05402b17fmr4590pld.6.1680802493467; Thu, 06 Apr
 2023 10:34:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:c38a:b0:474:c743:9f91 with HTTP; Thu, 6 Apr 2023
 10:34:53 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <leea4982@gmail.com>
Date:   Thu, 6 Apr 2023 10:34:53 -0700
Message-ID: <CADa=nC2sGqtD6MWg=nESCJ3Fg2HmtQk+jTvsXz9rjagCGQFGWQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello did you receive my message?
