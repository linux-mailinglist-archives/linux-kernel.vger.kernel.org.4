Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF173A0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjFVMf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjFVMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:35:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2DFDE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:35:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f900cd3f96so60370125e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687437323; x=1690029323;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tuZH5ttM+re1fJopaEvFkbmDwKSfTTd2NjudGSCuj6Q=;
        b=JMUibzOW8F1qk1qks5WF6FNhBceOZDtoVaFCgyz/P5eVHGdgMVceBECo3a5fzqMx+h
         bM6hCzILZCC/zfXE6ZnsABh9XKKPyk91rcBqjabnZ5RlMk5sn7ZFRDOFUteRmtyueIYe
         k2TL+2MyMtZmIDBFaT3cD1XbvLA+67zFeISxAvoCWmgIONojFrEbEKq5kkDBcMhyH79h
         QXQK2GA2k7T0pKItTr3vM6NzsyORsnihJvpEfFUnepbyNof8f3B71OW8o4NCVX7O0Xe7
         eye37V9GAvnLKwdx5FNACp9psltxSELJAtH0udsR0cHIupIOhFApNjs4fJ5ZFpArkpnu
         pOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437323; x=1690029323;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuZH5ttM+re1fJopaEvFkbmDwKSfTTd2NjudGSCuj6Q=;
        b=Y0c3XPUXdJjq8u8dML94Gh2B1AuVri+OMzbWZIrNyCSnZF0+5La5ypGAeMrsnrVsCe
         ASui7YUIWEpojjK77x2kpJ3w5VPWIVk/0R2k29HrGp2ItAO/iSEVc7Ci7woQkpJdcjef
         PskBZhpQ0acnX9YAe3YtVLHBfYpv0Q4164vdTzMICJId7mFBoM7mxMACZziw6RCchKUt
         TmrNZoC9yZo+GxWzdL2K9gJhbZHCwy8Uuuf6gqz4P8w6TGNgq28nCaH1W0hKKyVR0gIL
         EPOWBl0SJ+VNi95rfG0imrOh9YU3DNqWkwCgtdPLnZ3Yb+kusnkkclOF9MplAcg4AxH/
         HJ8w==
X-Gm-Message-State: AC+VfDyp7DmC01ACBJGkA9aIH/QzI/huKcw2jkWMXglXISoRN/rILhFf
        kzUI6wL/mgek2TS/rRQZ4hqEIIJr8MojL9Fn1Ho=
X-Google-Smtp-Source: ACHHUZ5jPceSh0KJe5f6i15E1okTmrSIyU0V38QlPYVyMUag9UjEwg08VKsUnaGh/CdpO3VXeaRz6NwT0vyAuEy1dlE=
X-Received: by 2002:a7b:cbcd:0:b0:3fa:74bf:f028 with SMTP id
 n13-20020a7bcbcd000000b003fa74bff028mr952740wmi.0.1687437322346; Thu, 22 Jun
 2023 05:35:22 -0700 (PDT)
MIME-Version: 1.0
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Thu, 22 Jun 2023 08:35:07 -0400
Message-ID: <CABWLsesOzR=Wpc1TTp3PLXAuWUfX-heUnUys7ffM=Jzn-mEbxw@mail.gmail.com>
Subject: Re: [PATCH v4] ALSA: hda/realtek: Add quirks for ROG ALLY CS35l41 audio
To:     tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, luke@ljones.dev, perex@perex.cz,
        ruinairas1992@gmail.com, sbinding@opensource.cirrus.com,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Is this patch specific to the Ally, or does it cover other Asus
laptops discussed in this thread [1]?

Thanks!

[1] https://lore.kernel.org/lkml/b4c202b2-ab29-e2aa-b141-0c967b2c1645@opensource.cirrus.com/T/#m42ec3f3f4ceb610430587b916281b570fbb666df
