Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CCB6A225A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBXTah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXTaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:30:35 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A378916326
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:30:33 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso219991oti.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baWonEXSb/K4v/yFSvVpNeU0JFI/BWw4Lj8lad4SY58=;
        b=DDuygg/iiiPeklme7zXyGv1NcSiu0o48RK+9TP5brtdJ/+OLCJ1buU3uwaj3w5pk1A
         m59DVHuUl5IqMyF1EAULv6h9bankikBvDgHFvEXg1hKDUpWIsO0S902DvVRcGFlX2W7L
         HWC2zFQfOBYXpYjkQN6k1JCvgTJLTG9g4yKlCfLn1lvloJdR9end9Wc9YEC7f9DC4uCf
         Br3A555rPfK0FFHgW2EiU+w34yikHuB13EvrNtGwNsF3JzsgGO19RJQL7W5+v/DCoE4P
         smD3jRL9JK+58bgFtlwBCuHEtPnl0XZAgX9+bdWWqsP5zT4mzSdLfJiSX3xDyconLlIb
         wwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baWonEXSb/K4v/yFSvVpNeU0JFI/BWw4Lj8lad4SY58=;
        b=Ibu69uhN2kYNCZCf1faoM+oHMMr35tzecHU2sU5V+9ZroEn4JHHd1GL82omWAuEJcT
         WOgvGjisgtGS3dhtpjoL2sancuTzI7hq+iTmU41XafSy2bV05LYFvPupnsJ1NfSzGbQ7
         eRoL24PliDuEv/pw8zUVvie6rEA107Haa8zJU1+1I4Tt4xAaBpQehBV/FmoIFa4PSD1x
         pc8Tt5EGcXgAjOyMm8Rfn45aSt7rrJ9FvupWSyEwCledkT1H2lkFntwxnAFKLNwR165z
         sxeV2C9pwynFnD4K8fEt/aW/qQ8PYznpiu4VtEOgsFyxYSLKUipLIpf75VjlepoYTfxP
         PwcA==
X-Gm-Message-State: AO0yUKU1GmZeYgHO4IZHar9ee5uA1oD0ZgsX/hvcRH6sLqW0sJcsN0RV
        WBZ/y2rbrUAmSbK3oYAFFuXjII5D4mv0KardQGU=
X-Google-Smtp-Source: AK7set98X+2rYms8dgtLqn6K6ZJ1rfQB2OkhlqfCtn7p9776FaltsbES6KeP+D9Mzfjf7i/72y5n4ZR8loKJMFB/CXc=
X-Received: by 2002:a9d:490e:0:b0:693:c521:f86d with SMTP id
 e14-20020a9d490e000000b00693c521f86dmr1826434otf.6.1677267032973; Fri, 24 Feb
 2023 11:30:32 -0800 (PST)
MIME-Version: 1.0
Sender: ifeanyiu301@gmail.com
Received: by 2002:a05:6839:4829:b0:5fb:542e:7c47 with HTTP; Fri, 24 Feb 2023
 11:30:32 -0800 (PST)
From:   Anthony Kwami <kwamianthony939@gmail.com>
Date:   Fri, 24 Feb 2023 11:30:32 -0800
X-Google-Sender-Auth: iGwtV2Q_zg1lDzNJY3WYTjpX7VI
Message-ID: <CAESJ23BRLjtWnb4WHNCUfJpzpnQJvXrBtABbeCRQG5RrJ92YdA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have something very important to discuss with you. This is an
essential detail that will help you.


With regards,
Anthony
