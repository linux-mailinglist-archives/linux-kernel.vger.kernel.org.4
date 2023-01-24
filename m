Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1146793BE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjAXJOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjAXJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:14:51 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491817CE3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:14:50 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id b18so3551269uan.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=fLz+UQHeSItl9xI2Ia5XJ5c4AemfBORNgS9Ubqx4W2vmRdzotxHwHkpjVJVdwBhZWZ
         nz6W4Q+nMxcHJtYC0gKRDvH2miFOhvhYjVnFwP0UfDn/uMD2J9O6kYcbXaKdk3rgt0VM
         v0MXLluMZdcx6qo4PNW1mwPoLbbvVlnDQNeC0mTo4kqoXWhUwYxDiH2RfAFG1Tq0BfLo
         Qu6JCth9UY7ap0c+7nUSsMjNbc+ry728WX6Hpvu6trTybdKzZsbDpgBJnqS1j3SKPKU1
         px8E/VJWkJmRwAOKdQ9/Y4UvQC7HRg8ktmhKeWmggRPQxPZZ9dwgX0Ilwfztz3q8LyQN
         olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=M6TiZ3BGjb9WzwerejeBGzbDK+lKVLqoYBVbliAtHZ8wgwtTU815uFuru2twC7Lkmn
         /HVA5vHcbYcOqlsOz1Mq4BUj+dIjF2ORGJmGZDLHuc9Ah8Y8kugOeBXeA7p13683V/SP
         KO4UfKfrkq57y47/qle/uAIJkUvxmSxQSNZsIOuJ1khu0g/4+NUyIe+rguNPB6payApo
         Xe3iNQvz3CigF5gR+Hu2du3yoIKIiue4j3P3b2OQuG/kHIQxnmcOjqozxztJ/FP3J1RZ
         SoQZZVdTElqqSjLeLjh+vitc3mUnGAtCIS8mL1+TirNQAVyzlQ5ZGZZcPPuDfJfP7zVo
         LVmQ==
X-Gm-Message-State: AFqh2kpe1ErJ+kvPkM1rdxE4kgaEz4gRlHQZZw5ypm6P3Nfx8E3ZewxW
        E/SIq6uzCCQPBII5ki+WEObQWY291c95foZtrFA=
X-Google-Smtp-Source: AMrXdXtOANR9dmskhSFWB6ptgtqSy/JjJKh8QJUwC+/r/BSVFJIi4HowQQTJBorgPcRN3BMcz3lIuLlKt5KvZiigykg=
X-Received: by 2002:ab0:2250:0:b0:418:f8f7:d9d7 with SMTP id
 z16-20020ab02250000000b00418f8f7d9d7mr2998274uan.116.1674551689636; Tue, 24
 Jan 2023 01:14:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:612c:158a:b0:374:ffed:88a6 with HTTP; Tue, 24 Jan 2023
 01:14:49 -0800 (PST)
Reply-To: westernuniont27@gmail.com
From:   Western Union Togo <victoiremaman90@gmail.com>
Date:   Tue, 24 Jan 2023 09:14:49 +0000
Message-ID: <CAOcDBPhq5KwHb+JOm0MBVv7UNVvdwdjUoz_K59k8265ZeMs3DA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your overdue fund payment has been approved for payment via Western Union
Money Transfer. Get back to us now for your payment. Note, your Transaction
Code is: TG104110KY.
