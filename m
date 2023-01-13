Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A366A5F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjAMWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjAMWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:32:45 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E392A8D5CC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:32:16 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id l185so7654417vke.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=TX2ITUSoiij4MR7y56NOK2ED/hkFtNiMURj9FlxXzbIhibPYIdzOg9v7ujoz5xhjwB
         Qi8qYo+nN5nVrF5ng7scli1BgPoX/Y91yKLmHl+2VeCrS5C8vI9QMyul3UItcnzhi3IK
         Oea9QvDzS9k+zGz+MMFcKR8Cko2+wmWmfP8/Et2YlGrmK990hqCD/hItE25qDHGp+o2X
         OVO+FjD/x7vPIbKgyttKVtntrQuukRVeB+7V0v3YRdYuWM56QtFYefCeZ3nZF2nQFOT/
         VgA+ZvnpfNzWU341HV5p56BfIkvpcS9Zcla7QJfDnwQJ7+JN2f1RG67vz4aSOdovnS/n
         Raog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=TSsZTOS3QYU5uzl/4N7dO8kq5G0h+q3ign+WxZssUNtrSNGiMLbLdGOoV+wnxJxVBP
         vCUhDyDwNyDcLMl7aNXP3FFCWlQMe4c8tBpv/MyjUp5oqkNzx6ICJrXLU+Yx+CsvjI0a
         nh2kNCQmum/92x210nnBQNE+YQrE4LhM1FKm+1he560XyPcHT89M9AvnLttPV27g0OA/
         YVvsVXu/4Izw8d7GoDDekalRefpVauoeUHAyBmmZfmuUfYxQxFzv0Dbrl6qj/jwhguMf
         jnr4ZNuS8yodrNR9vW8YrR92H3oSeRdgTKJOsygMvzeshes7A1+kiUuul4LLjq7l9NCh
         7ZIQ==
X-Gm-Message-State: AFqh2kprP83Kv51YefJFp+Eb/tXPsigQVNOhJTEDc5I6QkVZppBeJyTV
        JaM+3yx4ynY6L1HljgF7mmGrrwvkZa1EWnqSDdzXCa69Ff0=
X-Google-Smtp-Source: AMrXdXtTDJHxPzuFQB2/Y6nFIfReNddmXa/hiOVapmJY+qv4U5uQUOGZLJRfH0E/AsBn53aZos5ukqZgHI7NUolKHtI=
X-Received: by 2002:a05:6a00:1244:b0:56b:8181:fe3e with SMTP id
 u4-20020a056a00124400b0056b8181fe3emr5621436pfi.57.1673649124799; Fri, 13 Jan
 2023 14:32:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:610a:b0:8b:17f3:698a with HTTP; Fri, 13 Jan 2023
 14:32:03 -0800 (PST)
Reply-To: ava014708@gmail.com
From:   Dr Ava Smith <avatue70707at@gmail.com>
Date:   Fri, 13 Jan 2023 14:32:03 -0800
Message-ID: <CAOo2rrmbjraGJgAxJ5kMb-mNoYVE5ogyjOYtGgVZvKfJ6ziFUQ@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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
