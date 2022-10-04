Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575B45F42B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJDMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJDMJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:09:57 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68C7120B3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:09:55 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c19so8179622qkm.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=N/GSbPnALToZPDvWcwsyZl8roxv+rx6jEvhzi+rz9/I=;
        b=RTneg+MYbqpdaR6DcxBkEgRYdkdGT/nADaTZZPJZhvDAxzQPMs7m0A2kPVP6DINta4
         WdfZUL4yQK8pw0FZOhVIXMhp1fk9pH+eJbK5Tqx+MCmSr1USpUcUoa7R9Rf1767wKqb1
         AeRT7DAaIvyy4+h7qUbsua/2q1lWUfWr4n+TbCX0HX1HBcT0mBFzdtKd3JHTz9AnLfhH
         se3y1acPQeJ/o3ky7rz4qZHWhvekWf7ycSpF/dwpQiZiZ45k5LLkwa85BGasVUKsIZ2/
         +1ligvmFMYMCDNKBgIb8Zn3ysy2vpPj5fsOfXsfI+ZJWoW2WSBrDTNTf40maeocKHdhU
         iPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=N/GSbPnALToZPDvWcwsyZl8roxv+rx6jEvhzi+rz9/I=;
        b=7obcsPo2eL7P8tPrz2dl9Idpll1tRxUoaA8Pi8c2SYEnj4+lfcnMFlcjwD8CVBkAt5
         tZE3pCTmVYBXv/A4C1cMXd7iaRRkwsl/4LBBajzpiMp8bKgdz4Y5mdy2VrIK7pkm8JZ7
         DX8kFl9FEIFqr3jettderB0OY/9U4tQnDx1ugxjdeeWTtep8rdlU9wfqVE3dPdDxBheI
         9bLuod9bY+7A4OF8Npt7G+AiG1lKhYEgNEsIPjLhckJvkdzGS5Ss/DKb4VQuNsc/d+/6
         LS6+S1pENLI5vxlbs8sJdxfs2/txpp8Y2Rdv72vNshtfemJ7z0cSTDm25g+KdkW93cyH
         jC1g==
X-Gm-Message-State: ACrzQf1HlKEVSWjEMOTtCE+26ZAnO2PfjBV0gAGMTQPbVz/yzrKXd5Lf
        pwgzcA1KZLeCVOjssu77+3UslVkMMWhTNySvaK0=
X-Google-Smtp-Source: AMsMyM4c7UWZ/P//H5lPCULKTAbDFoUwMbX5ucMGGKxbqR2LU0v5E3jI+fDVx+oI/2ieimLC7TISfpZGVdvQ82KOyzs=
X-Received: by 2002:a05:620a:2789:b0:6cf:ba4b:28a6 with SMTP id
 g9-20020a05620a278900b006cfba4b28a6mr16512923qkp.520.1664885393869; Tue, 04
 Oct 2022 05:09:53 -0700 (PDT)
MIME-Version: 1.0
Sender: ogunmasaadesola@gmail.com
Received: by 2002:ad4:5baa:0:0:0:0:0 with HTTP; Tue, 4 Oct 2022 05:09:53 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Tue, 4 Oct 2022 05:09:53 -0700
X-Google-Sender-Auth: CPg-5DdLWHcHlje9aOZfg9L4guc
Message-ID: <CAEGnpV_nFDhqoNfYNonfNb8thmP+=uz5Ck+p1Qaea=ZhV5Uegg@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply
me.
