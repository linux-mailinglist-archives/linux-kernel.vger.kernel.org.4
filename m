Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014456BD56C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCPQWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCPQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:22:09 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30681A245
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:22:08 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id w4so1311636ilv.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678983727;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5ZrXU5jgXQn0XVrjMqAH34ooe0I0t296BlYZYfw7/M=;
        b=Chb6oQoh8mUKTNLuEotK+lThxeQcm8CoPjwUqm3iPvOa5WHhelRb0+Bw0I02u9Dsh9
         agGkluTJv5fRZXCo9UED1KsfzyUTFPPo/zc0sz1jNC8Ha4w+m/S6F0HSEWEafG/5gKSO
         9JzHtCQu0nBZV59PvFacUT2VPInysxhxttvEj1aT+flE5eWTEquhK/pwmASmwubORmaG
         5+1zI4A8sL8bjbxuQqg+ZB3a6maQ3b7sc6BCGSCfvjcOIfx0tbW5Lgy0XuQYSMxSQD5A
         ZsyGraZ0J7fve9RLZ6SqveyAgBLeA18PhLU84Ag71SkRWQfKu5h2i2KQBBLb1P0nOHML
         QHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678983727;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5ZrXU5jgXQn0XVrjMqAH34ooe0I0t296BlYZYfw7/M=;
        b=aJvMshTTkAb8eORVlBE3zjgJ+NekkbfQ2iNX9yD2VsRJmBrIpy/gHyzwBaAtwIqDxZ
         RbV+MFUNxUzgtg7VdTV0ipCwahfyVBKBq8PBLyyRJ4EERBf3Q5dk/DNTRLXoWsv/YWuw
         ozIQ1A/eQXDEvGI6SQakwjxPwB2Q54vm1DSJspP1ZWVVVah5ohqbZulxdRxn2DN1QJbP
         c9yIyIiygBOM5TEwcbCj86VSHIgRO94Sb43pC9Ec5eW8wuVCqW0oSMk0z1qGgKaMY7qK
         pkh9sVMEmlQG5PxpEyqj3U/AHhyCPPks6PhsFoXvCLP2cr3EHAIG1DjN3YW/0CNLLGNy
         VAIA==
X-Gm-Message-State: AO0yUKVfMmtNanqGTqtqIcRY4V4elFEg66XTC7M2EkjWRnPqhRhV+xcD
        kk5g4QDuAr5wGM0Mi9oybdL7cZEFeqxAUSMW/WQ=
X-Google-Smtp-Source: AK7set9Viz5SN76AZjQDfA87+f54kGoZ6SUuWt2bNJJIFaLvzZg1iDGCXr//iVN7u2T0uCTF57PYYEKVzOHV+eQ1TV4=
X-Received: by 2002:a05:6e02:d46:b0:310:9d77:6063 with SMTP id
 h6-20020a056e020d4600b003109d776063mr5090462ilj.5.1678983727537; Thu, 16 Mar
 2023 09:22:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ccb8:0:b0:3df:457e:1a81 with HTTP; Thu, 16 Mar 2023
 09:22:07 -0700 (PDT)
Reply-To: enocvendor6777@gmail.com
From:   " Emirates National Oil Company (ENOC)" <linhtranngoc516@gmail.com>
Date:   Thu, 16 Mar 2023 09:22:07 -0700
Message-ID: <CANCRbgKnOeyG-esSqWSp0=CUE0PqQ8reRnMM2QRAbbx5BA4zaQ@mail.gmail.com>
Subject: Emirates National Oil Company (ENOC)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:134 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [linhtranngoc516[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [linhtranngoc516[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [enocvendor6777[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are inviting your esteemed company for vendor registration and
intending partners for Emirates National Oil Company (ENOC)
2023/2024 projects.
These projects are open for all companies around the world, if you
have intention to participate in the process,
please confirm your interest by contacting us through our official
email address  project-ae@enocvendor-ea.com
MR. Nasir Khalid
Senior Project Manager
