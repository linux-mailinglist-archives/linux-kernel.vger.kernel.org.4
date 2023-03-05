Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71386AB1F2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCEUHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCEUHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:07:38 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A70166DC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 12:07:36 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id g9so3647313qvt.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 12:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678046856;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2XD/lnGb6wqP5beCOn5WCviv+KlTriN0tPq9p0OZx0=;
        b=ZiepaHz/3URShuzoFoTr0n9W8X5wcj246wGtTT/Olhn5ve+KWs9fHyddEJYhQzfN/3
         pBepIWgH+H6w+ohrTSwLN5fm5t7B7Bp+DJI9rA+wI1IUeRAc5nzQDVQXew+BdNxSszG/
         4DvutTPHqvy4HjwgihilnMqOtigWxYD5nm17BJ8vf4H6Ky2rjcRITsZe5BUCpI+0DMxK
         ArFPUtVQUXc2iR4Pa4ZDFcLv66H9muQThJUKgYsXQ98WbfsEKxkQtQAWGx4fTpUtat9n
         hHodksyqnAct1QlwMHy8PUxcKbBdaVZXj+3QCm8gFMYdugBlT+0zvOQ3Dt+NgvyaS4Af
         ZaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678046856;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2XD/lnGb6wqP5beCOn5WCviv+KlTriN0tPq9p0OZx0=;
        b=WGIBbfSI0KNURr/v7h8wfvLBXf/rXSqIxHk/mDI8fmhn1ZSXSc/AdS0hVVYWnJq1Ax
         ZCyTtqYw61eCmh/HRCYPDfnTNMGHiuEpM1UgJnrGm4O0nHqs9EN/HnB+EWZFe6xBoZfm
         z1m0pAU7hbd1GMApFgjXAJcEsetr/hYZtB2mzA1RDArKyl8//CPdojKeTQ8ficj2OQha
         y4btNgZPGwEgXGh6vEcqef0EKgqdbmrxiAAiWt/4Ln0LNal6TIhqv37S+4FOwJOOaUWw
         LNxxMglZy37QWgFGWHdfAHBPbBree/YyedYeOOIuhnBtJnQ1OfaHXTyif9o5Izt/HR4S
         j8JQ==
X-Gm-Message-State: AO0yUKUzH1gDWbXUbCsEX7IcdZkVAiX1Xl8O2i5obkeWd+76MXCqFET4
        GLRGLY5+3XbYQsVHWOODIWUuGjz496vUIXzB77E=
X-Google-Smtp-Source: AK7set8ffpGdQTQKZXseL19PQNbp0QAJxCqSTuBgQI6JOwZMNS6jG42VnLiplfWD5Ci8Tx/oBsGMXMN/O2OWL8pwwYU=
X-Received: by 2002:a05:6214:4c06:b0:56f:3aef:1633 with SMTP id
 qh6-20020a0562144c0600b0056f3aef1633mr2224377qvb.1.1678046856083; Sun, 05 Mar
 2023 12:07:36 -0800 (PST)
MIME-Version: 1.0
Sender: oliveromar280@gmail.com
Received: by 2002:ac8:4814:0:b0:3bf:a737:f12d with HTTP; Sun, 5 Mar 2023
 12:07:35 -0800 (PST)
From:   Caroline Wood <mrscaroline74@gmail.com>
Date:   Sun, 5 Mar 2023 21:07:35 +0100
X-Google-Sender-Auth: YeaIbx4Us4yTojhH2FT_Aouz_EI
Message-ID: <CALeCgsrVDmremjqmg5Q6mqLwMk=OdJ5SOazQQn55TKP+AwevtA@mail.gmail.com>
Subject: hi
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

Good day, Please did you received my message?
