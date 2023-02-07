Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873A68DF93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjBGSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjBGSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:05:21 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FE539CE0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:05:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hx15so44664582ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=XBJ8Jsauq/zDmYavYjf8V5yCG0nalsLV6Tx1lFjH/qYRfxy+EeQn2EAndABYzMZoRK
         WMLUtd9AB26AlusexbWsB2n3vxlUo/rASKoip/CZBinJWPuZy1+spoH8aM8gsgShnArf
         SzGaatOyJrTpblt2k1tAgHoU35z1RPcxg1izsAVorZ+mnCVYn8hRtEhug6pZVO4mTQHT
         NW2bO3xz9XpwsCo17ILh/cHiChlpLYNHQJW7TqtAOve18ZWJJ+B7kHr25kWAKw5ZLdrA
         /Vs9XQkZvB9B9z05xI3rPVx1+qkGAjhnJFKkCXUecTYOXDVlwENhO9NabeqbgvU1jbvp
         mKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=d5xs9lYP5EE+mePkfSfGiQOwHzIrQ2VkKlJ8tOoBtm8mvzfAJ1uo8oK8UUAS/8aEXX
         6veaD63oZNwpTRXY9+C7GkcAhmrOysARL3yK1nJHqGzsKI/mpaXJ+FETahzYjodIx8PF
         qmAtri46vBe8iZSeDhIh1FiD+ruHz+pMaw22e0EygPk5nqeQgJqmKOG2typqPfG+UzOn
         3JWX5NZEfEE47NOk94BC2voK3Uolaipkck4USCpLde5q/vUxrVMcHNJsfakxRgnNWU1i
         PjC6KwZbrnBmpiRdhv97ZlMuAX8nOL5Ss1k2vGOQwUZo+yteBRCOSTsfTgcFCR2g8eXe
         F07A==
X-Gm-Message-State: AO0yUKXMM0hqIPdIqJ2ltWsT6HJtULjZ1ll6aTc+UXdWh+eZDT3GEwvM
        O0NLpf5gj7Qj5CoZurp8Ega/84fsv7oEgchRroo=
X-Google-Smtp-Source: AK7set/LE4FjV1LI+kuMQJzglv+FlMCN/iuGLZ876mlV69vSxcDv/thQUvZMDzcnVwAbQmHbXjCFvNTZRnKc/iSp71g=
X-Received: by 2002:a17:906:1742:b0:885:8c79:ae31 with SMTP id
 d2-20020a170906174200b008858c79ae31mr1124417eje.261.1675793118982; Tue, 07
 Feb 2023 10:05:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:6d8c:b0:879:43d5:381e with HTTP; Tue, 7 Feb 2023
 10:05:18 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <avasmt003@gmail.com>
Date:   Tue, 7 Feb 2023 10:05:18 -0800
Message-ID: <CAPLw5fJ_ywLMU6cK71UxqsB2f_Nxv+ueND5UNy8e1eR4t_w6GQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [avasmt003[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [avasmt003[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
