Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A42656457
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 18:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLZR1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 12:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLZR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 12:27:09 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A50B7A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 09:27:08 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id c34so9565456edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 09:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gSxZmUkvILQpUAnRgK8JzgBcd5ZFOTCP/L342PwCczs=;
        b=ah1TB3j73b3CyGBmQV+fo8Sbtx3IvUpwut5owBLuoRvSgRk+Fje7rNpjyBxofWM0Io
         5/6TuoEyBX1vdaNkyxu/mPI2z2kH+au1M8XtBDa9IXHyHId1zUiHzRwak61y2qAZUWUm
         5wrgCNMJBimmENl3VBQlgVfjKU1swytH7/EeLoyWy3mMjK468yExbMRWQhHYlRYsnK6t
         O7jvaxFDsJsbmM/l4bklOT78+eFbO0zXD5/tpReYhRlaTrFXAMWwSficjroL6/DTue30
         GJnbwn1YYLa8L2Q7NVaOwb3+DVPkEHejSabTYnQAst6eY+EvqDnS5cAleSbp1ykGR1Lp
         ++VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gSxZmUkvILQpUAnRgK8JzgBcd5ZFOTCP/L342PwCczs=;
        b=EqZpQnr18TkoI/HU4YfwaOuOxPzOhsQro5oYusoQDXEcSJ43ipeDRXBNrZF68w0fXO
         11KD/QfZQ+cWvIM1eJj8xJ41J8rU8mE6XdLVrrm2BIAMvkggmbr+DQwe8AK2sLw4XRE9
         MXsDc6Bd1am8GLS7FCxyQbOqC4f/kiC2qDMSTIB0il7xdP16FpqVP12voNwwfHRke1fh
         dj8g/FUd/3QV4MCstz9v7JwmIbjdyrcvl8xBR9GIV+WeKPzv6f2JONeIkQPoVH5Xvw4m
         RzjkjTZmmSGR3b7pPEkV5tJKx32VLFXoTlJ2wLkBK5/h95iKAX9Uz4Un04rN8nGKxZpz
         GSjw==
X-Gm-Message-State: AFqh2ko/bUJxN44NXz5vY/6AMlKeZjLxUVykqkKD3YRzLnNdFRLlFjXZ
        ynpFmM73m/xhnEnOO5wCtNGd/GV/+g+enreeGZM31CHPT94=
X-Google-Smtp-Source: AMrXdXsVTC232ivDohkVeaZRgNH5LOGypnAY5NsnC2KxGS8pz2QU4V7KFrX9MvyRqbPWHBcqsiAP+lxfEf8SNmlYvWo=
X-Received: by 2002:a05:6402:31ef:b0:46d:d9be:1315 with SMTP id
 dy15-20020a05640231ef00b0046dd9be1315mr1884656edb.261.1672075626396; Mon, 26
 Dec 2022 09:27:06 -0800 (PST)
MIME-Version: 1.0
From:   Amit <amitchoudhary0523@gmail.com>
Date:   Mon, 26 Dec 2022 22:56:55 +0530
Message-ID: <CAFf+5zh-zhnwLPthD7dEJdOzOCKj0ki2tSaM5Wav30oA4ZVU+Q@mail.gmail.com>
Subject: Website that has backups of software hosted on sourceforge.net (https://www.onworks.net/).
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Website that has backups of software hosted on sourceforge.net
(https://www.onworks.net/).
