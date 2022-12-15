Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8398764D4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLOBGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLOBF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:05:59 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0644946659
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:05:59 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id q186so4108812oia.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=ONw6eA83W4El4bjL+V37oG04lW0MxXGPcKwtt11brLvf/jq92FP82aB7y/5murUq/m
         Aq6TtNin21RTLy2rIVGGORAW22CwWxacX/s18mQjKhRJOHIdy/eDm1CqPE/us4AIiMyp
         lHV5H403B92Q2VFT65f58lbvZGYcfKFGzyZV7Qat4z6SqgLMKfTDCjIOwDITCc7kQbF7
         4D6siLUoNXB7V33kMEZgseqVQC7wH+Qc9wJ6OS3s2VVaNyS+CpJkziGAzwLynUAeNEJl
         A0q1XV6evuLZjaW08r0YQK/Z4bEiTEvMgpUSFiwzrc1T/EOqVkaXZEhnhW8Ajwj+FeZ+
         68Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=rVeWiiVgkXqOK/TsJLPv++p2k6Cpn2/EeX+cqUX3bOAWL2Lm9p5f2Dp3y3lWBAFguP
         NdqCTz0yAIwMefy42OmVjHgVUNDcN0z530x2tddLox4HpLzIUMrTkyXgqUyyYH+ZPVKR
         a3mRuAv24j4KV6kFVi43ybQ8ZUWllxSyLzmblAGSlWWxL+Jmnykl8zXUvqEsHN5+1ciH
         uDChFGWKX8uoOKvwTYYXprGmsWvb9SMwiRY0YNgat1dYArs/U7lKVxBvXwFR6jO46ZdT
         oZOx+8GcRCV7hlHNLE65lJILnoRCiSqjrKYr4ecxzIEOpqBjhgNUomRbmZESKaPvcyY8
         9ieQ==
X-Gm-Message-State: ANoB5pkVWBFSx5BWQT14a09jrPj05ULoVBoSnzG1ZX48nY/iSIac9Y7c
        OE/tLOb5L30wr95VYWU3x6xuvre6kAu46+4Skjs=
X-Google-Smtp-Source: AA0mqf7nVaUC19kkd5A91k5cb8xho8/0WwB3cDJhNcnc79rTtCTifGqsCWFwivbR2WOl1dJ4wJ4HN2Xzg3V/m3WTbgE=
X-Received: by 2002:a05:6808:602:b0:354:7326:8b07 with SMTP id
 y2-20020a056808060200b0035473268b07mr210360oih.43.1671066357934; Wed, 14 Dec
 2022 17:05:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:18c:b0:df:3bf7:4f8c with HTTP; Wed, 14 Dec 2022
 17:05:57 -0800 (PST)
Reply-To: ava014708@gmail.com
From:   Dr Ava Smith <anabllescott@gmail.com>
Date:   Wed, 14 Dec 2022 17:05:57 -0800
Message-ID: <CAN4MwPyPBXifs_31c0AT0zJ1XeME+nmkNidwxg8__eQ7N9wY_w@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
