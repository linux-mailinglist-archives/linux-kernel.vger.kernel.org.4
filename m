Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690EC6BC63C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCPGnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCPGnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:43:31 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27603A6BF8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:43:23 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id o2so619809vss.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678949001;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUd4umpxujW8dQhFm7GbKLyv2cvu5uzXB1JatuvT2hk=;
        b=grztlYIs1CKJZkIpRD/ktBmrA+rd7ARqosVZVQXwY24QmYq3sFIP15KF8ik1S/iFn7
         EMNR3QB+SWfGJd+Ygzoe34SMvzlA++RMkwzz1CyB3A8pxdVgHi7HU6shviHcRnskLvkp
         Gp+bGdOVLxelUTXvszxiU0B1LInq4hw0B725WHpNHonWMRhKQ2chn10hSimbCesdFwz+
         cNnmtce4RRzMxRZCw/a2TFduAFwCIX6ACfxEDGj56X3zxFENSDBAuY8utWv3Mt/HStyD
         SiDd/vY5pk9mnpJm8/Wf+7m0RDkQbCvoi/1+D8XYJa13PDJ1BRHgXwO7mbAFmv1YJgyF
         NurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678949001;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUd4umpxujW8dQhFm7GbKLyv2cvu5uzXB1JatuvT2hk=;
        b=Q2aOfPP2+0miAJM+nIifU+UVda4Q4rE/UGjoAfpdUTjB60OISnfDg4FN1Ucc8libdn
         vqrmgy96VpHDu6h6lVVzW0ERCzLx6zZx/UW9dGOwM0/Jxpvd/ZVDfWYVQSED7kXnqZ53
         J/UdYYRLvEjD1us7y6zmdQBZSq4a3FGDEgpcL6XW0HBYBKT/5NbhX4OAi8hRPBPOTm1f
         EwRUL+InxAuCcXPEfczW7mu6C1LzgotTpieeZQQPizASz/egeF7kPMhfv0kYSE2WCeoJ
         xNOvCivVnYAP91mbaLKQlmPsBiPRB9Mb78c5HXH6UfEYaD9xlLY/cHyEytGEiQDrCM0l
         SsSg==
X-Gm-Message-State: AO0yUKUltjeEvltAeoxQ09R1Ix9ymYx9UF99pu3x/K4FRskH2lQ2KuHW
        Tc9MsbsCedorHQQAPV7A4QA80du0EeSJj8izVvM=
X-Google-Smtp-Source: AK7set+DSnw9hmVnTs7lzhBa78lpuwIvdTDQgpjDQv9yOpQasIudXFH6vLFlqRjrB/PQ/Gij7e5irL481LLQctK25HQ=
X-Received: by 2002:a05:6102:3d97:b0:425:174e:7c58 with SMTP id
 h23-20020a0561023d9700b00425174e7c58mr10333240vsv.1.1678949001443; Wed, 15
 Mar 2023 23:43:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: ditoamaali@gmail.com
Received: by 2002:a59:a86d:0:b0:385:8ff5:baf6 with HTTP; Wed, 15 Mar 2023
 23:43:21 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Thu, 16 Mar 2023 06:43:21 +0000
X-Google-Sender-Auth: 0heViNHSbynmXp5aP2sw5VintnA
Message-ID: <CAMZPD6ndFTAEuy_ogbA5-N=mm7JkZU27Ai4N5ijHxTN1G53kFQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, did you receive my two previous messages?
