Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E972F28D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjFNCWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFNCWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:22:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C641A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:22:42 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgpmT6PCmzBJL9t
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:10:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1686708633; x=
        1689300634; bh=Coxosl6j2ywY7ogLos2ae154xpI/eGkqov+EDC/rjTM=; b=A
        YnP+ppZAg8B0DKr4ragszC6sx7+FQHxhee6NWZvIq1+7AZja/9f2xBTaBRmkKO2f
        XGHgzSGk6ykQ5ouQF9zVcBibP/HZS0MA2zwCFjOpE8Gea2oTV8VxFmeiozHvZhXP
        4wlamhXtPhzJLvy9XZYyQAgzGfRyAGG5FO+druc/9v7FhkwU1x1LgtSMVHgLPpux
        uDB5rm0KdXteg9udptOHdLBs66Qpp8eh7Iu/7K5ZWUUVFBXORTX8tang4Ic7GDxj
        DfCv3RnhwzKpXt/lkBsQysflnMayyKgV7FHRINfx52AfLClf9LCt5Oi07Qo8o/Oi
        +lEjQTpZA++3YAz91WJEQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n330S14c3w6Q for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 10:10:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgpmT3xcVzBJL9m;
        Wed, 14 Jun 2023 10:10:33 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 10:10:33 +0800
From:   baomingtong001@208suo.com
To:     agk <agk@redhat.com>, snitzer <snitzer@kernel.org>,
        dm-devel <dm-devel@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] dm: remove unneeded variable
User-Agent: Roundcube Webmail
Message-ID: <202306141008237478337@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following coccicheck warning:



=C2=A0



drivers/md/dm-snap-persistent.c:909:14-16: Unneeded variable: "sz".



=C2=A0



Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>



---



drivers/md/dm-snap-persistent.c | 3 +--



1 file changed, 1 insertion(+), 2 deletions(-)



=C2=A0



diff --git a/drivers/md/dm-snap-persistent.c=20
b/drivers/md/dm-snap-persistent.c



index 15649921f2a9..7ea01bceba59 100644



--- a/drivers/md/dm-snap-persistent.c



+++ b/drivers/md/dm-snap-persistent.c



@@ -906,7 +906,6 @@ static unsigned int persistent_status(struct=20
dm_exception_store *store,



=C2=A0 status_type_t status, char *result,



=C2=A0 unsigned int maxlen)



{



- unsigned int sz =3D 0;



switch (status) {



case STATUSTYPE_INFO:



@@ -920,7 +919,7 @@ static unsigned int persistent_status(struct=20
dm_exception_store *store,



break;



}



- return sz;



+ return 0;



}



static struct dm_exception_store_type _persistent_type =3D {



--



2.40.1



=C2=A0


