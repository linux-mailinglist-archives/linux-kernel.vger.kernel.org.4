Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE316048D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiJSOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiJSOJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:09:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E2B111BA0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:51:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu25so28265711lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhbT+I+m/j1zIBMdGQ5YCdD5f5II+ZRqGX/fHpao/tc=;
        b=fvpixn8qJXpLejupAsnVUtkeZh9Od2Ad8gBNWgsmDYwm59P7g+gbVUHoQbML7nBo8n
         Gwg4bYHiI2DIMJSI/6TWr84FlPLFSPrh8f5ZqstHvtq7VRT+cXZ1QilhHv/RkX+dv8iG
         9Y94eD20a/7zc/8sLqBRgaAnMOGUbY/Zld3qLoUE2bPU9VqiY6BPtq+wFlUE64wSmxTR
         Fe48VC5wbnSDXkQd00WLm76gH6LnQv96Am/guH3tv1PNsLZ7A2gXIAvp12nIkynDzpUc
         EjM8W8zv4T0oKPLI1etBxtoyVo3J2lVPAV2Zq8WjJN0OGlf0oImXr9zWoK4DmitWE6bt
         YlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhbT+I+m/j1zIBMdGQ5YCdD5f5II+ZRqGX/fHpao/tc=;
        b=ftZKmicNjA7faZVe8yAblML8iE+K+iBbjhMXyc3rHMbnSixoupxVZGGTDVPy5lKgcu
         bMEDt/f4WR5TYnmG3diFIhS/ddhCVFKBIZ5QBXag261WJVX1rdavBYsg3eNnNqFExA/H
         /kyaRJI8LMyk9/ViOZzNIauLIV1EYDHJtDsmhg1hE2nVIKyuKg1FMnpFXwEvthlpf1cI
         tRWR7PLAMMcEXi2d/KlGK45+HljijEcD4vAE2BD3qkIyZC4Ig72IYfDQ1RwEs/yQ02MC
         vb+/e9RE7JwftCqA+oIPMHncrOu0RYAJsWD6CfWhDLYSPGH4QENLu6dFwI3TYDNFThT/
         sWKQ==
X-Gm-Message-State: ACrzQf1YfWJ/7qFpYHFGQ3cXQsIVUOlETYoVu3VyaxRQdiLxGIoFOB4g
        kDz/cqSsAM1ZOrSdTXqN509kVipU+LLvcQEcbCY=
X-Google-Smtp-Source: AMsMyM6fNllFKnEpQWVKhiWkVcRnT1H/YLvDxXWD1SLVtCsXnuaMpoSisWPsOyPmff1ANrTF8Wntv2M0Pel5aY0NU08=
X-Received: by 2002:a05:6512:10c2:b0:4a2:ed6:5020 with SMTP id
 k2-20020a05651210c200b004a20ed65020mr2769034lfg.22.1666187393156; Wed, 19 Oct
 2022 06:49:53 -0700 (PDT)
MIME-Version: 1.0
Sender: mrssahah1ibrahim@gmail.com
Received: by 2002:a05:6500:c17:b0:167:1e3b:4b23 with HTTP; Wed, 19 Oct 2022
 06:49:52 -0700 (PDT)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Wed, 19 Oct 2022 13:49:52 +0000
X-Google-Sender-Auth: 1A-jeLktcuojagCvfHMJcGOaxvQ
Message-ID: <CAN=unoZ3fMFtvL3vP7tg9w8pt=QSMzzETSRLQDTmvQ9f1V+8Ww@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I Wish to seek your conscience about something urgently, Please reply
this message, once you get it.
Yours sister,
Mrs.Elena Tudorie
Email: tudorie_elena@outlook.com
