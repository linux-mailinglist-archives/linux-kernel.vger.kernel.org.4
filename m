Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916EE6FB16A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjEHN1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:27:01 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77268E70A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:27:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7577ef2fa31so280824885a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683552419; x=1686144419;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21T2ruoV7Hb2byNjXRrKdStLSJ9N1tOpZrLYkVqWI4g=;
        b=aX8dhtJ3Of8LskEHMPZUnsrWqNtDscG4RcldfbwS8Rk5MGGHAzAWoCfvckzi1JJ+p8
         +ENMwfFP8Mal3HHrXZ7Z/6gBObNQUrKv1rdsj9FOS+EAcwpULt2H0y8diJ+n1GIQpaFI
         HU239dtelTmUXRsfSKW/WiyCooiUhkILOrXlkkiWj0qBert5tmcfpxmfjihLtHkZO1/l
         L8OILMLdLyLPiFxlunazgq/L4r37cg7aLsiY5g55vyC6/h7Mqyvp0BdGuNF06hp2CsYN
         ocY8UPYc7V8MNKGHru4M6/OFpx7vUIIcDsfrWwmHLJiGVhCQ7z3cNRj5pIUU+pywNwgv
         RtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683552419; x=1686144419;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21T2ruoV7Hb2byNjXRrKdStLSJ9N1tOpZrLYkVqWI4g=;
        b=IsSizfO0ZCTQ3nmRBlbKZtjAX7WXnJuAqOLBjUnQMS6ojPbfN5FsKyqimvdq6Eh9cE
         3/FX7Nh+kj7COyLeZSWvtgIqFpi9jXb1vDfezS8X/eCTkJRciyRi4Nx9CMViGbG0RcbG
         2uu40QF6GM+yAxSeG0hWpZsxTO1Y5bFjVh+BdhB+EbIQnDmR6TGBjUGuSXuu095uRPpx
         O2n4hkLsDBxFZh7bW5Nx0my3h3vaLlldA0tPkmXWmJ0Gy2Ab85afN+SZKEeNL9FVLhmZ
         uGHGBF6DSW+QxOYiMIIDKJAy+98CrgrsvW+/cRCUGUyrlEHvrwdUYN/TMP7GXWoh/DXA
         daLQ==
X-Gm-Message-State: AC+VfDw6lHwZCumrsGyah/TjhUs3Fwnd0E/RES1qjBXNS568YzvKb2YF
        PljVQCgCt3VuzG1FnEwFOiyyDErFvQx7bsjv8F8=
X-Google-Smtp-Source: ACHHUZ7T9W7EIITLa1TsAqjEQmo5ihJZHu0wAuDPkjDo3XKSP+xKv20ecO/5TD7HvM0TSL+kCd2tYQLT02mbRMBJxDw=
X-Received: by 2002:ad4:5ecf:0:b0:619:90cd:4a99 with SMTP id
 jm15-20020ad45ecf000000b0061990cd4a99mr16664111qvb.3.1683552419471; Mon, 08
 May 2023 06:26:59 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.adnaali.muhamad01@gmail.com
Received: by 2002:a05:6214:2f8c:b0:61a:cb7d:5031 with HTTP; Mon, 8 May 2023
 06:26:59 -0700 (PDT)
From:   Mrs Suzara Maling Wan <mrssuzaramailingwan12@gmail.com>
Date:   Mon, 8 May 2023 14:26:59 +0100
X-Google-Sender-Auth: dh7Oql1BfHNkGjmevQYWnOTmn50
Message-ID: <CAMhMFrGk35rbE9sfO-L5LQ5ZvG8D9av59d8_rK71xdRmKJW_WA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mrs Suzara Maling Wan, I have a desire to build an orphanage home
in your country and also support the poor and less privilege in your
society, I want you to handle this project on my behalf, I have $4.5
Million Dollars with Ecobank to execute this project .

If you are in a good position to handle this project, reply for
further details of the project

Regards
Mrs Suzara Maling Wan
