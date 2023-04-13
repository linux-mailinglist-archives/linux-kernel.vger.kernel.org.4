Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA5A6E0340
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjDMAgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMAgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:36:41 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FC5449D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:36:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760a6703d90so1420439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681346199;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BXzGy7WHjSScQkD/Qf2J5z99N//XgZkjjaDXm3xA8U=;
        b=H/STNCdATwsPdMMP9QiadmkP1IhgfWcGAIvl2bJRWlSIBWToPxEsQSFUtPFScjX+fK
         wr0JCF92Sh5K2kIa501EUVfTBR7O/RhldwXpyjC05GUj/o4rsmlp1iG9uitClkm5S42Z
         DdD6bLkUWQzCIWH6AApArjNpLTPuGFTo/Tcgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681346199;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6BXzGy7WHjSScQkD/Qf2J5z99N//XgZkjjaDXm3xA8U=;
        b=PIn32J84E7UbIPIzCtps3r/l31NB+P+wHjDu6/2vpwxEL/EXFYaYPDTCxpByqIaqpb
         4irYw9TjHc23DarNnu1jyIUsSzaKMnLa98EbpwWTdPp0WJ3m09sCbv5wiwBa3M2Pam8q
         0OudDnQqaJNUmH/ONS99brXHAzgvNg4tujgTeJohmp87xExsHGZgGDS5i5VlqWKDn6yD
         FV5UDFwR+vfE48vfDS4RIioaYx9US/MUjOYJQ6DQF2T2OQZH3MepzcieCGbDZoSA78kn
         znvsUwFSkqQ/GKKF3PtmJq5ZIfpbbFs02GmcjdRMLqK6qsKxwnYCVCey5H8lacI1+lIk
         uwxw==
X-Gm-Message-State: AAQBX9drQd5RyspNhqZbJ7V3Thf0CS4rnJTFY7qCCGFhPwUhURmq1KJh
        7ELBPcJF88Sr9PfRPR9C3Wi4pzQEfTK3RN5IMJk=
X-Google-Smtp-Source: AKy350YbfoIh0LIN1/2+QnvknGwNqtJ1/xJJgKUCCa/TAvY06bLoMM2mkIvSty6qSJ2I5vLObdBrVg==
X-Received: by 2002:a05:6e02:1d92:b0:328:4634:7ed5 with SMTP id h18-20020a056e021d9200b0032846347ed5mr172881ila.0.1681346198871;
        Wed, 12 Apr 2023 17:36:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s20-20020a92ae14000000b0031796c6d735sm93732ilh.41.2023.04.12.17.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 17:36:38 -0700 (PDT)
Message-ID: <557ef895-ad2d-eff9-7cb8-70dbcf41adea@linuxfoundation.org>
Date:   Wed, 12 Apr 2023 18:36:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     conduct@kernel.org, tech-board@lists.linux-foundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux Kernel Code of Conduct Committee: March 31, 2023
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Code of Conduct Committee: March 31, 2023

In the period of October 1, 2022 through March 31, 2023, the Code of
Conduct Committee received the following reports:

Unacceptable behavior or comments in email: 6

The result of the investigation:
  - Education and coaching clarifying the Code of Conduct conduct
    related to normal review and patch acceptance process: 1
  - Clarification on the Code of Conduct conduct related to
    maintainer rights and responsibility to reject code: 5

The reports were about the decisions made in rejecting code and these
actions are not viewed as violations of the Code of Conduct.

Please see the excerpt from the Responsibilities section in the
code-of-conduct-interpretation.rst document:

"setting expertise expectations, making decisions and rejecting unsuitable
contributions are not viewed as a violation of the Code of Conduct."

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to
uphold the professional standards of our community. If you have
questions about this report, please write to <conduct@kernel.org>.

--------------------------------------------------------------------

This report and the past Code Of Conduct Committee reports
can be found on the Code of Conduct website at

https://www.kernel.org/code-of-conduct.html

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)
