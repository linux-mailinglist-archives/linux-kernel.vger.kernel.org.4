Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835CB73D29A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjFYQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:58:59 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81C10D;
        Sun, 25 Jun 2023 09:58:57 -0700 (PDT)
Message-ID: <c6bdd0651da37fc6be56c269942eaf2f.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1687712334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8htG7rHHL97H05txH4/SKfeVPifIbRS3sVXBTSrVOSE=;
        b=D3TQs+t+fqsVCOxjbYzX4cBlkf8bknlCcKts8Uo6HfyveOsXzfP2iPdWV2e69VNPXKF+kX
        LTQxCiNc9KCxKUPrsO2sr19YJG6S36t+Fixs1CZP9d5bGXzMHo/COmaVHRREPw3sz4iRwA
        a5AklFyEhTQmjd7DaM/54PwUkYIRSojOGpyEVib75uoYSVAX1BvWNvqFAqN0wDAZpIoVWZ
        MAfxMIGZxKTUnaBmHIc+yJ9FKQV9xFDUcIXQzz5V1OMT3EDF6U0zLd6rOKLkYqT6ECg/zB
        Li2ddXXre26pZcPbkPpaEuEy1x3HALetpaewlXQMH5MPHERH4jiYJwAkDJO3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1687712334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8htG7rHHL97H05txH4/SKfeVPifIbRS3sVXBTSrVOSE=;
        b=iRUBwExV1Lvs9hPbjJabR5A9ZJvEWiKRr7aF2LViMB2C3+TNXq32Wy9L4WzYgIVnhMviam
        Bd7FhhDiIjrPzJ9R/SA/0QYwJe8LfPMy20xqHEKwnR6e15q3s3d1kPEUFCNr7wv0wMX+n9
        0zx4rYBqZqVGAxLIXRfUrN8Z2Aw3XEWdrbwhPh7wXs0w4sG6RHTvNyp0is3ONFUqj5ufu8
        mWNt1tdrCFW68hipZIEbidkiw5GOPn1a5fpw9xVXpO2gjbI1zuRRJhEfEVEpS3VmJZJfHm
        A+mp0s1TtLWAj9hYqB5Ne8FPllaKQ9dDUuPQbGqiouDez1ZB8gLACK6nKV8Zgw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1687712334; a=rsa-sha256;
        cv=none;
        b=RE/enp8w7n7guB26rl6danqPfbSofenjJIHR4AXZ0A5p8ftHFsrLfG5HXuoyfDcgxsn0Ka
        Vrbn/bNKPGSMpNezlEnXKbN7MXFydyZbk5nYM1kNuHGDvUehytDNbUVz3DrpLeqAX2HxG/
        KMZyNL5uUqsH4pOlgXnhzyH2BaRn3XTSd4oy5a9GQv8TwfO/pwDPwDLTasTUA21v8j+GNe
        k5SCkZea6kkdHhzPjjPX6fwQ7Q+qUQgrDC6HCAWBbUQGVkvKzsnJVoT6qcQ6/dZj4cVDdB
        MFaLTsaREE4htp9dJPuXs+CWswRmEvsDyn0FbUbW42XiQoFQOWu7td0xUuoi9g==
From:   Paulo Alcantara <pc@manguebit.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Rishabh Bhatnagar' <risbhat@amazon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pc@cjr.nz" <pc@cjr.nz>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: RE: [PATCH 5.4 2/5] cifs: Get rid of kstrdup_const()'d paths
In-Reply-To: <043b05d64bca40509bab7dd8e368e4e5@AcuMS.aculab.com>
References: <20230623213406.5596-1-risbhat@amazon.com>
 <20230623213406.5596-3-risbhat@amazon.com>
 <043b05d64bca40509bab7dd8e368e4e5@AcuMS.aculab.com>
Date:   Sun, 25 Jun 2023 13:58:45 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> writes:

> From: Rishabh Bhatnagar
>> Sent: 23 June 2023 22:34
>> From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>
>> 
>> commit 199c6bdfb04b71d88a7765e08285885fbca60df4 upstream.
>> 
>> The DFS cache API is mostly used with heap allocated strings.
>> 
> ...
>> -	ce->path = kstrdup_const(path, GFP_KERNEL);
>> +	ce->path = kstrndup(path, strlen(path), GFP_KERNEL);
>
> That is entirely brain-dead.

Yep.  It's got fixed up later by

        8d7672235533 ("cifs: don't cargo-cult strndup()")
