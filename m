Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE86B6E2FA8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDOIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDOIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:12:28 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5745260
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:12:26 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1879edfeff5so7544221fac.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681546345; x=1684138345;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OX9NXQ0tzRd7xyF3pHsUEqSMqLROvvhyA2/x81O8ujw=;
        b=LUgjwVNUuq3zdK67pwNuBA31IgTvAMMx/xbEgL9ncIz+IxmKXkJfiRfcsdBTnjZIwN
         Q1QNfMY3y+j86AcJKH04dRWWG2voJ+JvVGagw8kiiLI/WSOUDmlDtcqFL2o2YKFJpWQT
         be1fdTwpR23EoPfvPNv8VnzwC1DiVVwYXuhw6H3BrjlEFVRk0EPnloW/ESXxlryZBHph
         CSihEKkWgmguz7bL/X5iPlJv2fSdnfs6ld6iXpgptliIHTsa5bTa4Io3lPTV0TA5hdKz
         raGy4GwlyCsZGSHrCmmbaaQ4doKitfoUR31N4XH0bKIuXknpOwnCz6ianGErfmFRLpD9
         dS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681546345; x=1684138345;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OX9NXQ0tzRd7xyF3pHsUEqSMqLROvvhyA2/x81O8ujw=;
        b=WkeNNxo06bRZovFkwq+oeqZbfc4xrlZN+UJg7XHbVbyT+Rn1ZT+3bndWaoTkxBJ3zk
         GOEHLPTZAMN5Yb1hZxDsWL4iewKjQC6NUMkaE/lPZ+7RDh61YlbouU6gWmPGjPlwzLhc
         4Ilw+/wmooeCH0lzbgxTKZXlNrZYapTkTdzWfXh/Cs0Lv0hIAiAcSVEIcvJ70QxzXNKe
         Jbzr+iUu2CcWSo9OTNRSpd+zTuMzakxAOGzvshPLInQ/jPuLMSWs4YQFDYz2/5yrFCAw
         vSWc2XGH11IAldaENPn1dwb6Wy/bduQ8VkMLKD0bILy9G6+BR9PuK7d8VMyY4cYzL84H
         T77w==
X-Gm-Message-State: AAQBX9eZTUAino18Ah0T/FwiTcM4ZqY5P1EaNddacXWsGibE2PKvSKrz
        5lhI7NV5zBGZwlrP4w/yXAGgqpxy0pEdc10L++I=
X-Google-Smtp-Source: AKy350ahARvkgzPkq76yWzgPJjWWckKIjsaG6G23OQIU0DC0h68TCtJ/pbHz/9HEALpaj0m/xA1JxDD1liAlVdbjrLk=
X-Received: by 2002:a05:6870:b24f:b0:177:abbb:f20c with SMTP id
 b15-20020a056870b24f00b00177abbbf20cmr4289542oam.0.1681546345619; Sat, 15 Apr
 2023 01:12:25 -0700 (PDT)
MIME-Version: 1.0
Sender: fcfghjkghcvdcm@gmail.com
Received: by 2002:a05:6870:c08a:b0:177:b992:fee1 with HTTP; Sat, 15 Apr 2023
 01:12:25 -0700 (PDT)
From:   Danny Gabriel <dannygabriel9813@gmail.com>
Date:   Sat, 15 Apr 2023 08:12:25 +0000
X-Google-Sender-Auth: V8kOmVG3OEeJyIqR0dyfSaJnV38
Message-ID: <CAA7Nyx2p3vEhgQsZqASVBLCXer=vNm-yDdvHii0v0_RUW1wocA@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am so sorry contacting you in this means especially when we have
never met before. I urgently seek your service to represent me in
investing in your region / country and you will be rewarded for your
service without affecting your present job with very little time
invested in it

My interest is in buying real estate, private schools or companies
with potentials for repaid growth in long terms

So please confirm interest by responding back
My dearest regards
