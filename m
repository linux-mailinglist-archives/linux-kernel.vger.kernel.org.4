Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D9609534
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJWRlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJWRk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:40:59 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DCC60E8C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:40:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q1so6866951pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9/SuezSRqcLUP48JqdbpCdVoYhLOJgB5OdXCSdqDxM=;
        b=oVDRE//fs8/q4s99IXfRWuAezNjA1/gD5BdPSwiZigOjdQE7An9vYSMHccwd1atkZm
         8A1IWFaTqaWJlxudnXgnWOPN5pCB7ch4AYzQv4vDLG3yKDLz6ddjpa/dqVSPgmM7kQr7
         Ed1Vfit9PaH0ZDtWV56823rDF+wpC8lSn4oL76zEwfzt6o5ROdQ+3+3Fk3oC/Evhvx5h
         ZKQL2CEkEmr8ptxOVqB8XfQmwKDs6bWeEea4cG8co/FQH1W2aDllt7+Jg74Y3GTZCtNg
         En4ZEXSeMTCBFHLDs5K+imB1y5oeIHnWlRQjkcIG+RF8ngYgjSzsqISjPiF4SblLxMNL
         Umfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9/SuezSRqcLUP48JqdbpCdVoYhLOJgB5OdXCSdqDxM=;
        b=12GasYCN3uyfTCmnYqPzhQ0srSb5XYr6bszyGUReVH4ofrNItgf6FOFlLbPzuZHf6h
         5xJGKNGeHH4xeLKUwZaV1+4TNvUvEUSLZzXkafvNbsUoesA3z64jA3yIXV3IxS7cn1eX
         5MD9Zb8d/E34c/ALXSzm2bo0cjNtmX0qaaQmZSOCioTfinFHTnESEjpzgqmqhZJldPGj
         YGTsfYO8uNPFHgQ+hd9R9tarYyfWAuzcQVfbsp/YjoKQ3COdwAOqg3xz7euvic6nSTGf
         Tv6O9skLZtd6D+aEnul2XnG71gu0O+woW7VOVnNRjJ+56gqO/yiHPs/BMEZiORxSNXqN
         e7CQ==
X-Gm-Message-State: ACrzQf0FVcH/zBg/7lENl/dWKl7wGryess+z50FNENteWlTiZte8t57a
        uzpma9/G+ZKKCH3cxB1LHMNjzLMZT2BlOrdG3t8=
X-Google-Smtp-Source: AMsMyM78uq2whYpuUuH5jnXf4AuDe7sgj73y/18tEi0jVnn1BeY+XChjabgKSbm3w264iZvdpdx11z1jWVoD4YoyZgs=
X-Received: by 2002:a63:f20a:0:b0:464:8c6:f27e with SMTP id
 v10-20020a63f20a000000b0046408c6f27emr24937574pgh.411.1666546858053; Sun, 23
 Oct 2022 10:40:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:c785:b0:2fc:bb9d:1c1f with HTTP; Sun, 23 Oct 2022
 10:40:57 -0700 (PDT)
From:   Ericq Brown <ericabcgf@gmail.com>
Date:   Sun, 23 Oct 2022 21:40:57 +0400
Message-ID: <CAFr8O37tyJ2SFnOnZFV7Cs9yE8V64GE=pKF_mewKgag2x8zObA@mail.gmail.com>
Subject: INVITATION...International Conference on Human Rights and Human
 Dignity (ICHRHD2022)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The (ICHRHD2022) Conference  Committee invites you to the
International Conference on Human Rights and Human Dignity
(ICHRHD2022) ,  taking place from the 20th - 23rd of November 2022 in
Boston the United States of America and from the 26th - 30th of
November 2022 in Saint Louis - Senegal. under the sponsorship of the
ICHRHD2022 Conference Committee .

Visa arrangements and documentation to obtain the US Visa. That will
include delegates Round Trip Air Tickets to both events , Feeding and
Transportation to both events. Delegates will only be responsible for
his or her own hotel accommodation in Saint Louis - Senegal where the
second phase of the conference event will take place.

For details on Registration Contact our Registration Desk Email:
registration.IPCRC2022@outlook.com

Regards
(ICHRHD2022) Conference Committee
