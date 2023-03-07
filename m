Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F66AD6EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCGFlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCGFlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:41:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A306C185;
        Mon,  6 Mar 2023 21:40:59 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id ky4so12971709plb.3;
        Mon, 06 Mar 2023 21:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678167659;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGv6GHE27MGSVflQtDHPfQYBafwMHw6AkZ/7Wt1ZWkE=;
        b=h5OMMYCzFXuGXQtnbN+6XKj3cOqI6u2244jsCBx9DvFfWe1prwRzjjrcW8h5mZUVsl
         QmtkU7oAEqBmOVOf3By0/ENqG1da+qEjKw8kw4fgSFHoLvJVa6DQugYcc9U1yI7SWEei
         dMGMlInHwzV4GzSN4SL1CfwaI/eEAMNxQDJc1IpuhmCs5Utn8Msj9OaxrYrV8cOsSDBu
         mFPn77jHctXK2An5AlqFoAmLNBFbtLbfDQ6by1EiYLIHXqj2e6SaNEoN+KTAXlLI2K+J
         PpXm8GsCqN4MGUjTEHSTiSJ1nvf4ZuYjpl7O+me1lna4SRlB1kKl3UKnrGkxrhUzS9wa
         fpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678167659;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vGv6GHE27MGSVflQtDHPfQYBafwMHw6AkZ/7Wt1ZWkE=;
        b=2TZ/2gHgDX19c8oo2yZZm1ajCJR/aN+ohsfJR5w0qM5ChF+3UfqXTaXhX8RNtfraSW
         ll3pKhX+erJSnxF0HnSF+uYQ4CqSmHk5nNo2nf0aWNUscx9Syb51iT8GQ4JMapfRvuKQ
         zqWVUkyN2ur9t5TDd7NhuJUDhUTI99hpsuegu5liTPHacnz4pezXK3dHbxrD6+w90bEc
         ip8PMtaJmKFst+kKJMAb4c+jj0cral1aplUHa7bp/lXAhEXWEqXcbIKLpksuc4zIPIK4
         gDAovLCdeM9XVtvSHtxpVi7oDaC/fFaYlsqoGGR+QKgLfWU74eS6Zt7Ro9M3bqVnBC/P
         4qNg==
X-Gm-Message-State: AO0yUKWTz2CAv0qwMaSGeEjqeUxKN3mZWl4dCPt9QfZuA6uz3CRt02fH
        gAVrOmPs3TiFOSZY//niLWH4epSY51Q=
X-Google-Smtp-Source: AK7set8VC3fm3ZkdCGJzVjZzCmrjLdp7cGedega8vr5ALkoyI34URjaCfZ8FcGpRnpm9rseLgW0qhQ==
X-Received: by 2002:a17:902:d381:b0:19c:d537:754 with SMTP id e1-20020a170902d38100b0019cd5370754mr12496238pld.56.1678167659064;
        Mon, 06 Mar 2023 21:40:59 -0800 (PST)
Received: from localhost ([203.220.77.23])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902cf4700b0019adfb96084sm7615183plg.36.2023.03.06.21.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 21:40:57 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 07 Mar 2023 15:40:53 +1000
Message-Id: <CQZWS8VFIL3Q.G9POORQXDKE0@bobo>
Cc:     <ajd@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <cmr@bluescreens.de>
Subject: Re: [RFC PATCH 13/13] Documentation: Document PowerPC kernel DEXCR
 interface
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Benjamin Gray" <bgray@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.13.0
References: <20221128024458.46121-1-bgray@linux.ibm.com>
 <20221128024458.46121-14-bgray@linux.ibm.com>
In-Reply-To: <20221128024458.46121-14-bgray@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 28, 2022 at 12:44 PM AEST, Benjamin Gray wrote:
> Describe the DEXCR and document how to interact with it via the
> prctl and sysctl interfaces.

Oh you've got the docs here, sorry. Thanks for that. I don't know enough
yet to give much useful feedback on the API. I think at least all the
mechanism stuff up to the prctl API looks pretty straightfoward so would
like to get that merged if we can.

Might need a bit more time and discussion on the API. Interestingly
because the hashchk aspect is architectural, we may not be able to
necessarily sanely enable that, because if it was disabled to start
out with, our callchain up to the prctl call I think would have no
return hashes set so we'd immediately fail on our first return.

Thanks,
Nick

