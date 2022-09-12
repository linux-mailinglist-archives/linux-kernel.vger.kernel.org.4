Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015DB5B567F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiILImk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiILImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:42:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB821E2F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:42:33 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t6-20020a17090a950600b0020063f8f964so3854218pjo.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=kdwSesT/NAk1gjx3PN/r4zk+qQDOTQCkBvSZMCJUdRM=;
        b=HAS1tZdxHjKMGGyqzjH/wmb0xm58h/LQV2g9YZRjaNlXlvvJOyLSfs1RKmDCni48bU
         YTt1vcVKqCJOvZ+E6M59LlNoHj6IvEA1NiS64FW4KmC2O/+q6AaFOmPfzMZUY4jfIXRZ
         8M6Fg5f7D/mSXDsNmkTMx9Q6jd+56gGkjtnODk9mDtUCTNWG1KwowjCqSl/F9pzEUPxv
         dQ3/nWVXXdVm9saDBpIY0f+uAPialimOjU7gZx3T25Pz+R2IH5RKLp05qGIH7xYKxXaT
         55/74PU7rHQ8tVaZrbuTaEJnwLHbFC4Ytm/K31D9KOyioADe9JssC2wq2OE2uFvyBwnn
         UxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kdwSesT/NAk1gjx3PN/r4zk+qQDOTQCkBvSZMCJUdRM=;
        b=LHowgJDhU6hbj4S+gohp4VwJnwErf52mqayfKM7m3f/c8iLeMGMQLceibfbrbghjvS
         sQzXsVnDvw0XFVfuRPxl/uQSMvvREQ9mKTglaiKHzQMcwFXBTHjDgblDJeVUh4d1pRCD
         wsrdU6dRhrH5ygztzajjGurI003MjjH96LNdRShsSrIjRhJKaxZnQQIlA1xir/kdHqPR
         IlkV9nEqXJ37n9Pj2iAmPc2n0PxXgUq+wEsX4rPAsxndsK1nWo/4I3Jxzg67kYeYj6g/
         PNfOFVQXwGBsomeMA5wkfdD46ReHSkhfYoAry61laIUYmXe5BwXAbVkYEpdOcXnji3JF
         tqIg==
X-Gm-Message-State: ACgBeo3PLwVUfTfoLRbEbAmgLfGteB05+l1Dn3neY0mUCwMafsPulUgx
        kOPhfvKaH2BTYwagv6FvQRk=
X-Google-Smtp-Source: AA6agR66li5f4g8l6fOFGoTw7AoBtEwcnenkjn05wxOxUGHCH3YUozojzKh5ATPXGm2sgG/T+Sl5Zg==
X-Received: by 2002:a17:902:ecc5:b0:178:3217:e464 with SMTP id a5-20020a170902ecc500b001783217e464mr4090708plh.75.1662972152027;
        Mon, 12 Sep 2022 01:42:32 -0700 (PDT)
Received: from debian.me (subs09b-223-255-225-238.three.co.id. [223.255.225.238])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b001749dff717dsm5289814pln.227.2022.09.12.01.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 01:42:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 44585100015; Mon, 12 Sep 2022 15:42:26 +0700 (WIB)
Date:   Mon, 12 Sep 2022 15:42:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v14 01/70] Maple Tree: add new data structure
Message-ID: <Yx7w8gXqZMS+fEgc@debian.me>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-2-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DpdX1Pe7WOtz6yvB"
Content-Disposition: inline
In-Reply-To: <20220906194824.2110408-2-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DpdX1Pe7WOtz6yvB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 07:48:39PM +0000, Liam Howlett wrote:
> diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-a=
pi/maple_tree.rst
> new file mode 100644
> index 000000000000..45defcf15da7
> --- /dev/null
> +++ b/Documentation/core-api/maple_tree.rst
> @@ -0,0 +1,217 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Maple Tree
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Liam R. Howlett
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Maple Tree is a B-Tree data type which is optimized for storing
> +non-overlapping ranges, including ranges of size 1.  The tree was design=
ed to
> +be simple to use and does not require a user written search method.  It
> +supports iterating over a range of entries and going to the previous or =
next
> +entry in a cache-efficient manner.  The tree can also be put into an RCU=
-safe
> +mode of operation which allows reading and writing concurrently.  Writer=
s must
> +synchronize on a lock, which can be the default spinlock, or the user ca=
n set
> +the lock to an external lock of a different type.
> +
> +The Maple Tree maintains a small memory footprint and was designed to use
> +modern processor cache efficiently.  The majority of the users will be a=
ble to
> +use the normal API.  An :ref:`maple-tree-advanced-api` exists for more c=
omplex
> +scenarios.  The most important usage of the Maple Tree is the tracking o=
f the
> +virtual memory areas.
> +
> +The Maple Tree can store values between ``0`` and ``ULONG_MAX``.  The Ma=
ple
> +Tree reserves values with the bottom two bits set to '10' which are belo=
w 4096
> +(ie 2, 6, 10 .. 4094) for internal use.  If the entries may use reserved
> +entries then the users can convert the entries using xa_mk_value() and c=
onvert
> +them back by calling xa_to_value().  If the user needs to use a reserved
> +value, then the user can convert the value when using the
> +:ref:`maple-tree-advanced-api`, but are blocked by the normal API.
> +
> +The Maple Tree can also be configured to support searching for a gap of =
a given
> +size (or larger).
> +
> +Pre-allocating of nodes is also supported using the
> +:ref:`maple-tree-advanced-api`.  This is useful for users who must guara=
ntee a
> +successful store operation within a given
> +code segment when allocating cannot be done.  Allocations of nodes are
> +relatively small at around 256 bytes.
> +
> +.. _maple-tree-normal-api:
> +
> +Normal API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Start by initialising a maple tree, either with DEFINE_MTREE() for stati=
cally
> +allocated maple trees or mt_init() for dynamically allocated ones.  A
> +freshly-initialised maple tree contains a ``NULL`` pointer for the range=
 ``0``
> +- ``ULONG_MAX``.  There are currently two types of maple trees supported=
: the
> +allocation tree and the regular tree.  The regular tree has a higher bra=
nching
> +factor for internal nodes.  The allocation tree has a lower branching fa=
ctor
> +but allows the user to search for a gap of a given size or larger from e=
ither
> +``0`` upwards or ``ULONG_MAX`` down.  An allocation tree can be used by
> +passing in the ``MT_FLAGS_ALLOC_RANGE`` flag when initialising the tree.
> +
> +You can then set entries using mtree_store() or mtree_store_range().
> +mtree_store() will overwrite any entry with the new entry and return 0 on
> +success or an error code otherwise.  mtree_store_range() works in the sa=
me way
> +but takes a range.  mtree_load() is used to retrieve the entry stored at=
 a
> +given index.  You can use mtree_erase() to erase an entire range by only
> +knowing one value within that range, or mtree_store() call with an entry=
 of
> +NULL may be used to partially erase a range or many ranges at once.
> +
> +If you want to only store a new entry to a range (or index) if that rang=
e is
> +currently ``NULL``, you can use mtree_insert_range() or mtree_insert() w=
hich
> +return -EEXIST if the range is not empty.
> +
> +You can search for an entry from an index upwards by using mt_find().
> +
> +You can walk each entry within a range by calling mt_for_each().  You mu=
st
> +provide a temporary variable to store a cursor.  If you want to walk each
> +element of the tree then ``0`` and ``ULONG_MAX`` may be used as the rang=
e.  If
> +the caller is going to hold the lock for the duration of the walk then i=
t is
> +worth looking at the mas_for_each() API in the :ref:`maple-tree-advanced=
-api`
> +section.
> +
> +Sometimes it is necessary to ensure the next call to store to a maple tr=
ee does
> +not allocate memory, please see :ref:`maple-tree-advanced-api` for this =
use case.
> +
> +Finally, you can remove all entries from a maple tree by calling
> +mtree_destroy().  If the maple tree entries are pointers, you may wish t=
o free
> +the entries first.
> +
> +Allocating Nodes
> +----------------
> +
> +The allocations are handled by the internal tree code.  See
> +:ref:`maple-tree-advanced-alloc` for other options.
> +
> +Locking
> +-------
> +
> +You do not have to worry about locking.  See :ref:`maple-tree-advanced-l=
ocks`
> +for other options.
> +
> +The Maple Tree uses RCU and an internal spinlock to synchronise access:
> +
> +Takes RCU read lock:
> + * mtree_load()
> + * mt_find()
> + * mt_for_each()
> + * mt_next()
> + * mt_prev()
> +
> +Takes ma_lock internally:
> + * mtree_store()
> + * mtree_store_range()
> + * mtree_insert()
> + * mtree_insert_range()
> + * mtree_erase()
> + * mtree_destroy()
> + * mt_set_in_rcu()
> + * mt_clear_in_rcu()
> +
> +If you want to take advantage of the internal lock to protect the data
> +structures that you are storing in the Maple Tree, you can call mtree_lo=
ck()
> +before calling mtree_load(), then take a reference count on the object y=
ou
> +have found before calling mtree_unlock().  This will prevent stores from
> +removing the object from the tree between looking up the object and
> +incrementing the refcount.  You can also use RCU to avoid dereferencing
> +freed memory, but an explanation of that is beyond the scope of this
> +document.
> +
> +.. _maple-tree-advanced-api:
> +
> +Advanced API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The advanced API offers more flexibility and better performance at the
> +cost of an interface which can be harder to use and has fewer safeguards.
> +You must take care of your own locking while using the advanced API.
> +You can use the ma_lock, RCU or an external lock for protection.
> +You can mix advanced and normal operations on the same array, as long
> +as the locking is compatible.  The :ref:`maple-tree-normal-api` is imple=
mented
> +in terms of the advanced API.
> +
> +The advanced API is based around the ma_state, this is where the 'mas'
> +prefix originates.  The ma_state struct keeps track of tree operations t=
o make
> +life easier for both internal and external tree users.
> +
> +Initialising the maple tree is the same as in the :ref:`maple-tree-norma=
l-api`.
> +Please see above.
> +
> +The maple state keeps track of the range start and end in mas->index and
> +mas->last, respectively.
> +
> +mas_walk() will walk the tree to the location of mas->index and set the
> +mas->index and mas->last according to the range for the entry.
> +
> +You can set entries using mas_store().  mas_store() will overwrite any e=
ntry
> +with the new entry and return the first existing entry that is overwritt=
en.
> +The range is passed in as members of the maple state: index and last.
> +
> +You can use mas_erase() to erase an entire range by setting index and
> +last of the maple state to the desired range to erase.  This will erase
> +the first range that is found in that range, set the maple state index
> +and last as the range that was erased and return the entry that existed
> +at that location.
> +
> +You can walk each entry within a range by using mas_for_each().  If you =
want
> +to walk each element of the tree then ``0`` and ``ULONG_MAX`` may be use=
d as
> +the range.  If the lock needs to be periodically dropped, see the locking
> +section mas_pause().
> +
> +Using a maple state allows mas_next() and mas_prev() to function as if t=
he
> +tree was a linked list.  With such a high branching factor the amortized
> +performance penalty is outweighed by cache optimization.  mas_next() will
> +return the next entry which occurs after the entry at index.  mas_prev()
> +will return the previous entry which occurs before the entry at index.
> +
> +mas_find() will find the first entry which exists at or above index on
> +the first call, and the next entry from every subsequent calls.
> +
> +mas_find_rev() will find the fist entry which exists at or below the las=
t on
> +the first call, and the previous entry from every subsequent calls.
> +
> +If the user needs to yield the lock during an operation, then the maple =
state
> +must be paused using mas_pause().
> +
> +There are a few extra interfaces provided when using an allocation tree.
> +If you wish to search for a gap within a range, then mas_empty_area()
> +or mas_empty_area_rev() can be used.  mas_empty_area() searches for a gap
> +starting at the lowest index given up to the maximum of the range.
> +mas_empty_area_rev() searches for a gap starting at the highest index gi=
ven
> +and continues downward to the lower bound of the range.
> +
> +.. _maple-tree-advanced-alloc:
> +
> +Advanced Allocating Nodes
> +-------------------------
> +
> +Allocations are usually handled internally to the tree, however if alloc=
ations
> +need to occur before a write occurs then calling mas_expected_entries() =
will
> +allocate the worst-case number of needed nodes to insert the provided nu=
mber of
> +ranges.  This also causes the tree to enter mass insertion mode.  Once
> +insertions are complete calling mas_destroy() on the maple state will fr=
ee the
> +unused allocations.
> +
> +.. _maple-tree-advanced-locks:
> +
> +Advanced Locking
> +----------------
> +
> +The maple tree uses a spinlock by default, but external locks can be use=
d for
> +tree updates as well.  To use an external lock, the tree must be initial=
ized
> +with the ``MT_FLAGS_LOCK_EXTERN flag``, this is usually done with the
> +MTREE_INIT_EXT() #define, which takes an external lock as an argument.
> +
> +Functions and structures
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/linux/maple_tree.h
> +.. kernel-doc:: lib/maple_tree.c

The documentation can be improved (both grammar and formatting), like:

---- >8 ----

diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api=
/maple_tree.rst
index 45defcf15da71a..c1aa6bf3ab5edd 100644
--- a/Documentation/core-api/maple_tree.rst
+++ b/Documentation/core-api/maple_tree.rst
@@ -10,36 +10,36 @@ Maple Tree
 Overview
 =3D=3D=3D=3D=3D=3D=3D=3D
=20
-The Maple Tree is a B-Tree data type which is optimized for storing
+The maple tree is a B-Tree data type which is optimized for storing
 non-overlapping ranges, including ranges of size 1.  The tree was designed=
 to
 be simple to use and does not require a user written search method.  It
 supports iterating over a range of entries and going to the previous or ne=
xt
 entry in a cache-efficient manner.  The tree can also be put into an RCU-s=
afe
 mode of operation which allows reading and writing concurrently.  Writers =
must
-synchronize on a lock, which can be the default spinlock, or the user can =
set
-the lock to an external lock of a different type.
+synchronize on a lock (which can be set to either the default spinlock or =
an
+external lock of a different type).
=20
 The Maple Tree maintains a small memory footprint and was designed to use
-modern processor cache efficiently.  The majority of the users will be abl=
e to
-use the normal API.  An :ref:`maple-tree-advanced-api` exists for more com=
plex
-scenarios.  The most important usage of the Maple Tree is the tracking of =
the
+modern processor cache efficiently.  For most users, using the
+:ref:`normal API <maple-tree-normal-api>` will suffice. The
+:ref:`advanced API <maple-tree-advanced-api>` is available for more complex
+scenarios.  The most important usage of the maple tree is the tracking of
 virtual memory areas.
=20
-The Maple Tree can store values between ``0`` and ``ULONG_MAX``.  The Maple
-Tree reserves values with the bottom two bits set to '10' which are below =
4096
+The maple tree can store values between 0 and ``ULONG_MAX``. It reserves
+values with the bottom two bits set to ``10`` which are below 4096
 (ie 2, 6, 10 .. 4094) for internal use.  If the entries may use reserved
 entries then the users can convert the entries using xa_mk_value() and con=
vert
 them back by calling xa_to_value().  If the user needs to use a reserved
-value, then the user can convert the value when using the
-:ref:`maple-tree-advanced-api`, but are blocked by the normal API.
+value, then the value can be converted when using the advanced API; however
+converting that way is blocked by the normal API.
=20
-The Maple Tree can also be configured to support searching for a gap of a =
given
-size (or larger).
+The maple tree can also be configured to support searching for a gap of a
+given size (or larger).
=20
-Pre-allocating of nodes is also supported using the
-:ref:`maple-tree-advanced-api`.  This is useful for users who must guarant=
ee a
-successful store operation within a given
-code segment when allocating cannot be done.  Allocations of nodes are
+Pre-allocating of nodes is also supported by using the advanced API. This =
is
+useful for users who must guarantee a successful store operation within a
+given code segment when allocating cannot be done. Allocations of nodes are
 relatively small at around 256 bytes.
=20
 .. _maple-tree-normal-api:
@@ -47,39 +47,40 @@ relatively small at around 256 bytes.
 Normal API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Start by initialising a maple tree, either with DEFINE_MTREE() for statica=
lly
+Start by initializing a maple tree, either with DEFINE_MTREE() for statica=
lly
 allocated maple trees or mt_init() for dynamically allocated ones.  A
-freshly-initialised maple tree contains a ``NULL`` pointer for the range `=
`0``
+freshly-initialized maple tree contains a ``NULL`` pointer for the range 0
 - ``ULONG_MAX``.  There are currently two types of maple trees supported: =
the
-allocation tree and the regular tree.  The regular tree has a higher branc=
hing
+allocation tree and the regular tree. The regular tree has a higher branch=
ing
 factor for internal nodes.  The allocation tree has a lower branching fact=
or
 but allows the user to search for a gap of a given size or larger from eit=
her
 ``0`` upwards or ``ULONG_MAX`` down.  An allocation tree can be used by
-passing in the ``MT_FLAGS_ALLOC_RANGE`` flag when initialising the tree.
+passing in the ``MT_FLAGS_ALLOC_RANGE`` flag when initializing the tree.
=20
-You can then set entries using mtree_store() or mtree_store_range().
-mtree_store() will overwrite any entry with the new entry and return 0 on
-success or an error code otherwise.  mtree_store_range() works in the same=
 way
-but takes a range.  mtree_load() is used to retrieve the entry stored at a
-given index.  You can use mtree_erase() to erase an entire range by only
-knowing one value within that range, or mtree_store() call with an entry of
-NULL may be used to partially erase a range or many ranges at once.
+After initializing the tree, you can set entries using mtree_store() or
+mtree_store_range(). mtree_store() will overwrite any entry with the new e=
ntry
+and return 0 on success or an error code otherwise. mtree_store_range() wo=
rks
+in the same way but takes a range instead. mtree_load() is used to retrieve
+the entry stored at a given index. You can use mtree_erase() to erase an
+entire range by only knowing one value within that range. mtree_store() ca=
ll
+with an entry of ``NULL`` may be used to partially erase a range or many
+ranges at once.
=20
 If you want to only store a new entry to a range (or index) if that range =
is
 currently ``NULL``, you can use mtree_insert_range() or mtree_insert() whi=
ch
-return -EEXIST if the range is not empty.
+return ``-EEXIST`` if the range is not empty.
=20
 You can search for an entry from an index upwards by using mt_find().
=20
-You can walk each entry within a range by calling mt_for_each().  You must
-provide a temporary variable to store a cursor.  If you want to walk each
+You can walk each entry within a range by calling mt_for_each(). A tempora=
ry
+variable must be provided to store a cursor.  If you want to walk each
 element of the tree then ``0`` and ``ULONG_MAX`` may be used as the range.=
  If
-the caller is going to hold the lock for the duration of the walk then it =
is
-worth looking at the mas_for_each() API in the :ref:`maple-tree-advanced-a=
pi`
-section.
+the caller is going to hold the lock for the duration of the walk then use
+mas_for_each().
=20
-Sometimes it is necessary to ensure the next call to store to a maple tree=
 does
-not allocate memory, please see :ref:`maple-tree-advanced-api` for this us=
e case.
+Sometimes it is necessary to ensure the next call to store to a maple tree
+does not allocate memory. See :ref:`advanced API <maple-tree-advanced-api>`
+for details.
=20
 Finally, you can remove all entries from a maple tree by calling
 mtree_destroy().  If the maple tree entries are pointers, you may wish to =
free
@@ -89,24 +90,26 @@ Allocating Nodes
 ----------------
=20
 The allocations are handled by the internal tree code.  See
-:ref:`maple-tree-advanced-alloc` for other options.
+:ref:`maple-tree-advanced-alloc` for details.
=20
 Locking
 -------
=20
 You do not have to worry about locking.  See :ref:`maple-tree-advanced-loc=
ks`
-for other options.
+for how to use external locking.
=20
-The Maple Tree uses RCU and an internal spinlock to synchronise access:
+The Maple Tree uses RCU and an internal spinlock to synchronize access.
+
+The following methods takes RCU read lock:
=20
-Takes RCU read lock:
  * mtree_load()
  * mt_find()
  * mt_for_each()
  * mt_next()
  * mt_prev()
=20
-Takes ma_lock internally:
+The following methods takes ``ma_lock`` internally:
+
  * mtree_store()
  * mtree_store_range()
  * mtree_insert()
@@ -117,13 +120,13 @@ Takes ma_lock internally:
  * mt_clear_in_rcu()
=20
 If you want to take advantage of the internal lock to protect the data
-structures that you are storing in the Maple Tree, you can call mtree_lock=
()
-before calling mtree_load(), then take a reference count on the object you
-have found before calling mtree_unlock().  This will prevent stores from
-removing the object from the tree between looking up the object and
-incrementing the refcount.  You can also use RCU to avoid dereferencing
-freed memory, but an explanation of that is beyond the scope of this
-document.
+structures that you are storing in the maple tree, you can call
+``mtree_lock()`` before calling mtree_load(), then take a reference count
+on the object that have been found before calling ``mtree_unlock()``.  This
+will prevent stores from removing the object from the tree between looking=
 up
+the object and incrementing the refcount.  You can also use RCU to avoid
+dereferencing freed memory, but an explanation of that is beyond the scope=
 of
+this document.
=20
 .. _maple-tree-advanced-api:
=20
@@ -133,27 +136,27 @@ Advanced API
 The advanced API offers more flexibility and better performance at the
 cost of an interface which can be harder to use and has fewer safeguards.
 You must take care of your own locking while using the advanced API.
-You can use the ma_lock, RCU or an external lock for protection.
+``ma_lock``, RCU or an external lock can be used for protection.
 You can mix advanced and normal operations on the same array, as long
-as the locking is compatible.  The :ref:`maple-tree-normal-api` is impleme=
nted
-in terms of the advanced API.
+as the locking is compatible.  The :ref:`normal API <maple-tree-normal-api=
>`
+is implemented in terms of the advanced API.
=20
-The advanced API is based around the ma_state, this is where the 'mas'
-prefix originates.  The ma_state struct keeps track of tree operations to =
make
-life easier for both internal and external tree users.
+The advanced API is based around the ``ma_state``; this is where the ``mas=
``
+prefix originates.  The ``ma_state`` struct keeps track of tree operations
+to make life easier for both internal and external tree users.
=20
-Initialising the maple tree is the same as in the :ref:`maple-tree-normal-=
api`.
-Please see above.
+Initializing the maple tree that uses advanced API is same as the one that
+uses normal API.
=20
-The maple state keeps track of the range start and end in mas->index and
-mas->last, respectively.
+The maple state keeps track of the range start and end in ``mas->index`` a=
nd
+``mas->last``, respectively.
=20
 mas_walk() will walk the tree to the location of mas->index and set the
-mas->index and mas->last according to the range for the entry.
+``mas->index`` and ``mas->last`` according to the range for the entry.
=20
-You can set entries using mas_store().  mas_store() will overwrite any ent=
ry
+You can set entries using mas_store(). It will overwrite any entry
 with the new entry and return the first existing entry that is overwritten.
-The range is passed in as members of the maple state: index and last.
+The range is passed in as members of the maple state: ``index`` and ``last=
``.
=20
 You can use mas_erase() to erase an entire range by setting index and
 last of the maple state to the desired range to erase.  This will erase
@@ -162,9 +165,8 @@ and last as the range that was erased and return the en=
try that existed
 at that location.
=20
 You can walk each entry within a range by using mas_for_each().  If you wa=
nt
-to walk each element of the tree then ``0`` and ``ULONG_MAX`` may be used =
as
-the range.  If the lock needs to be periodically dropped, see the locking
-section mas_pause().
+to walk each element of the tree then 0 and ``ULONG_MAX`` may be used as
+the range.  If the lock needs to be periodically dropped, use mas_pause().
=20
 Using a maple state allows mas_next() and mas_prev() to function as if the
 tree was a linked list.  With such a high branching factor the amortized
@@ -173,32 +175,32 @@ return the next entry which occurs after the entry at=
 index.  mas_prev()
 will return the previous entry which occurs before the entry at index.
=20
 mas_find() will find the first entry which exists at or above index on
-the first call, and the next entry from every subsequent calls.
+the first call and the next entry from every subsequent calls.
=20
 mas_find_rev() will find the fist entry which exists at or below the last =
on
-the first call, and the previous entry from every subsequent calls.
+the first call and the previous entry from every subsequent calls.
=20
-If the user needs to yield the lock during an operation, then the maple st=
ate
+If you need to yield the lock during an operation, then the maple state
 must be paused using mas_pause().
=20
 There are a few extra interfaces provided when using an allocation tree.
 If you wish to search for a gap within a range, then mas_empty_area()
-or mas_empty_area_rev() can be used.  mas_empty_area() searches for a gap
-starting at the lowest index given up to the maximum of the range.
-mas_empty_area_rev() searches for a gap starting at the highest index given
-and continues downward to the lower bound of the range.
+or mas_empty_area_rev() can be used. The former searches for a gap
+starting at the lowest index given up to the maximum of the range, while t=
he
+latter searches for a gap starting at the highest index given and continues
+downward to the lower bound of the range.
=20
 .. _maple-tree-advanced-alloc:
=20
 Advanced Allocating Nodes
 -------------------------
=20
-Allocations are usually handled internally to the tree, however if allocat=
ions
-need to occur before a write occurs then calling mas_expected_entries() wi=
ll
-allocate the worst-case number of needed nodes to insert the provided numb=
er of
-ranges.  This also causes the tree to enter mass insertion mode.  Once
-insertions are complete calling mas_destroy() on the maple state will free=
 the
-unused allocations.
+Allocations are usually handled internally to the tree. However, if
+allocations need to occur before a write occurs then calling
+mas_expected_entries() will allocate the worst-case number of needed nodes
+to insert the provided number of ranges. This also causes the tree to enter
+mass insertion mode.  Once insertions are complete calling mas_destroy() on
+the maple state will free the unused allocations.
=20
 .. _maple-tree-advanced-locks:
=20
@@ -207,8 +209,8 @@ Advanced Locking
=20
 The maple tree uses a spinlock by default, but external locks can be used =
for
 tree updates as well.  To use an external lock, the tree must be initializ=
ed
-with the ``MT_FLAGS_LOCK_EXTERN flag``, this is usually done with the
-MTREE_INIT_EXT() #define, which takes an external lock as an argument.
+with the ``MT_FLAGS_LOCK_EXTERN flag``. This is usually done with the
+MTREE_INIT_EXT() macro, which takes an external lock as an argument.
=20
 Functions and structures
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 2effab72add10e..c03652fba05e17 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -153,18 +153,22 @@ enum maple_type {
=20
=20
 /**
- * DOC: Maple tree flags
+ * DOC: Flags and constants
  *
- * * MT_FLAGS_ALLOC_RANGE	- Track gaps in this tree
- * * MT_FLAGS_USE_RCU		- Operate in RCU mode
- * * MT_FLAGS_HEIGHT_OFFSET	- The position of the tree height in the flags
- * * MT_FLAGS_HEIGHT_MASK	- The mask for the maple tree height value
- * * MT_FLAGS_LOCK_MASK		- How the mt_lock is used
- * * MT_FLAGS_LOCK_IRQ		- Acquired irq-safe
- * * MT_FLAGS_LOCK_BH		- Acquired bh-safe
- * * MT_FLAGS_LOCK_EXTERN	- mt_lock is not used
+ * Maple tree flags:
  *
- * MAPLE_HEIGHT_MAX	The largest height that can be stored
+ * * ``MT_FLAGS_ALLOC_RANGE``	- Track gaps in this tree
+ * * ``MT_FLAGS_USE_RCU``	- Operate in RCU mode
+ * * ``MT_FLAGS_HEIGHT_OFFSET``	- The position of the tree height in the f=
lags
+ * * ``MT_FLAGS_HEIGHT_MASK``	- The mask for the maple tree height value
+ * * ``MT_FLAGS_LOCK_MASK``	- How the mt_lock is used
+ * * ``MT_FLAGS_LOCK_IRQ``	- Acquired irq-safe
+ * * ``MT_FLAGS_LOCK_BH``	- Acquired bh-safe
+ * * ``MT_FLAGS_LOCK_EXTERN``	- mt_lock is not used
+ *
+ * Maple tree constants:
+ *
+ * * ``MAPLE_HEIGHT_MAX``	- The largest height that can be stored
  */
 #define MT_FLAGS_ALLOC_RANGE	0x01
 #define MT_FLAGS_USE_RCU	0x02
@@ -498,7 +502,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned l=
ong min,
  *
  * Resets the error or walk state of the @mas so future walks of the
  * array will start from the root.  Use this if you have dropped the
- * lock and want to reuse the ma_state.
+ * lock and want to reuse the ``ma_state``.
  *
  * Context: Any context.
  */
@@ -513,8 +517,8 @@ static inline void mas_reset(struct ma_state *mas)
  * @__entry: Entry retrieved from the tree
  * @__max: maximum index to retrieve from the tree
  *
- * When returned, mas->index and mas->last will hold the entire range for =
the
- * entry.
+ * When returned, ``mas->index`` and ``mas->last`` will hold the entire
+ * range for the entry.
  *
  * Note: may return the zero entry.
  *
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e1743803c85125..d09485313f2f04 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5034,8 +5034,8 @@ static inline bool mas_anode_descend(struct ma_state =
*mas, unsigned long size)
  * mas_walk() - Search for @mas->index in the tree.
  * @mas: The maple state.
  *
- * mas->index and mas->last will be set to the range if there is a value. =
 If
- * mas->node is MAS_NONE, reset to MAS_START.
+ * @mas->index and @mas->last will be set to the range if there is a value=
=2E=20
+ * If @mas->node is ``MAS_NONE``, reset to ``MAS_START``.
  *
  * Return: the entry at the location or %NULL.
  */
@@ -5222,7 +5222,7 @@ static inline void mas_sparse_area(struct ma_state *m=
as, unsigned long min,
 	mas->index =3D max;
 }
=20
-/*
+/**
  * mas_empty_area() - Get the lowest address within the range that is
  * sufficient for the size requested.
  * @mas: The maple state
@@ -5277,7 +5277,7 @@ int mas_empty_area(struct ma_state *mas, unsigned lon=
g min,
 	return 0;
 }
=20
-/*
+/**
  * mas_empty_area_rev() - Get the highest address within the range that is
  * sufficient for the size requested.
  * @mas: The maple state
@@ -5629,10 +5629,11 @@ static void mas_wr_store_setup(struct ma_wr_state *=
wr_mas)
  * @entry: The entry to store.
  *
  * The @mas->index and @mas->last is used to set the range for the @entry.
- * Note: The @mas should have pre-allocated entries to ensure there is mem=
ory to
- * store the entry.  Please see mas_expected_entries()/mas_destroy() for m=
ore details.
+ * Note: The @mas should have pre-allocated entries to ensure there is mem=
ory
+ * to store the entry. See mas_expected_entries()/mas_destroy() for more
+ * details.
  *
- * Return: the first entry between mas->index and mas->last or %NULL.
+ * Return: the first entry between @mas->index and @mas->last or %NULL.
  */
 void *mas_store(struct ma_state *mas, void *entry)
 {
@@ -5665,10 +5666,12 @@ void *mas_store(struct ma_state *mas, void *entry)
  * mas_store_gfp() - Store a value into the tree.
  * @mas: The maple state
  * @entry: The entry to store
- * @gfp: The GFP_FLAGS to use for allocations if necessary.
+ * @gfp: The ``GFP_FLAGS`` to use for allocations if necessary.
  *
- * Return: 0 on success, -EINVAL on invalid request, -ENOMEM if memory cou=
ld not
- * be allocated.
+ * Return:
+ * * 0 on success
+ * * ``-EINVAL`` on invalid request
+ * * ``-ENOMEM`` if memory could not be allocated.
  */
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
 {
@@ -5708,9 +5711,9 @@ void mas_store_prealloc(struct ma_state *mas, void *e=
ntry)
  * mas_preallocate() - Preallocate enough nodes for a store operation
  * @mas: The maple state
  * @entry: The entry that will be stored
- * @gfp: The GFP_FLAGS to use for allocations.
+ * @gfp: The ``GFP_FLAGS`` to use for allocations.
  *
- * Return: 0 on success, -ENOMEM if memory could not be allocated.
+ * Return: 0 on success, ``-ENOMEM`` if memory could not be allocated.
  */
 int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 {
@@ -5729,13 +5732,12 @@ int mas_preallocate(struct ma_state *mas, void *ent=
ry, gfp_t gfp)
 	return ret;
 }
=20
-/*
+/**
  * mas_destroy() - destroy a maple state.
  * @mas: The maple state
  *
  * Upon completion, check the left-most node and rebalance against the nod=
e to
- * the right if necessary.  Frees any allocated nodes associated with this=
 maple
- * state.
+ * the right if necessary.  Frees any allocated nodes associated with @mas.
  */
 void mas_destroy(struct ma_state *mas)
 {
@@ -5773,17 +5775,17 @@ void mas_destroy(struct ma_state *mas)
 	mas->alloc =3D NULL;
 }
=20
-/*
+/**
  * mas_expected_entries() - Set the expected number of entries that will b=
e inserted.
  * @mas: The maple state
  * @nr_entries: The number of expected entries.
  *
  * This will attempt to pre-allocate enough nodes to store the expected nu=
mber
  * of entries.  The allocations will occur using the bulk allocator interf=
ace
- * for speed.  Please call mas_destroy() on the @mas after inserting the e=
ntries
- * to ensure any unused nodes are freed.
+ * for speed.  Please call mas_destroy() on the @mas after inserting
+ * entries to ensure any unused nodes are freed.
  *
- * Return: 0 on success, -ENOMEM if memory could not be allocated.
+ * Return: 0 on success, ``-ENOMEM`` if memory could not be allocated.
  */
 int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
 {
@@ -5839,11 +5841,12 @@ int mas_expected_entries(struct ma_state *mas, unsi=
gned long nr_entries)
  * @mas: The maple state
  * @max: The maximum index to check.
  *
- * Returns the next entry after @mas->index.
- * Must hold rcu_read_lock or the write lock.
- * Can return the zero entry.
+ * Context: Callers must hold ``rcu_read_lock`` or the write lock.
  *
- * Return: The next entry or %NULL
+ * Returns the next entry after @mas->index.
+ * The function can return the zero entry.
+ *
+ * Return: The next entry or %NULL.
  */
 void *mas_next(struct ma_state *mas, unsigned long max)
 {
@@ -5894,9 +5897,10 @@ EXPORT_SYMBOL_GPL(mt_next);
  * @mas: The maple state
  * @min: The minimum value to check.
  *
- * Must hold rcu_read_lock or the write lock.
- * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on not
- * searchable nodes.
+ * Context: Callers must hold ``rcu_read_lock`` or the write lock.
+ *
+ * The function will reset @mas to ``MAS_START`` if the node is ``MAS_NONE=
``.
+ * It will also stop on unsearchable nodes.
  *
  * Return: the previous value or %NULL.
  */
@@ -5957,12 +5961,12 @@ EXPORT_SYMBOL_GPL(mt_prev);
  * mas_pause() - Pause a mas_find/mas_for_each to drop the lock.
  * @mas: The maple state to pause
  *
- * Some users need to pause a walk and drop the lock they're holding in
+ * In some cases, there is a need to pause a walk and drop the held lock in
  * order to yield to a higher priority thread or carry out an operation
- * on an entry.  Those users should call this function before they drop
- * the lock.  It resets the @mas to be suitable for the next iteration
- * of the loop after the user has reacquired the lock.  If most entries
- * found during a walk require you to call mas_pause(), the mt_for_each()
+ * on an entry. If this is the case, this function should be called before
+ * the lock is dropped. It resets the @mas to be suitable for the next
+ * iteration of the loop after the user has reacquired the lock. If most
+ * entries found during a walk requires calling mas_pause(), the mt_for_ea=
ch()
  * iterator may be more appropriate.
  *
  */
@@ -5978,9 +5982,10 @@ EXPORT_SYMBOL_GPL(mas_pause);
  * @mas: The maple state
  * @max: The maximum value to check.
  *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * Context: Callers must hold ``rcu_read_lock`` or the write lock.
+ *
+ * If an entry exists, @mas->last and @mas->index are updated accordingly.
+ * The function may set @mas->node to ``MAS_NONE``.
  *
  * Return: The entry or %NULL.
  */
@@ -6021,9 +6026,10 @@ void *mas_find(struct ma_state *mas, unsigned long m=
ax)
  * @mas: The maple state
  * @min: The minimum value to check.
  *
- * Must hold rcu_read_lock or the write lock.
- * If an entry exists, last and index are updated accordingly.
- * May set @mas->node to MAS_NONE.
+ * Context: Callers must hold ``rcu_read_lock`` or the write lock.
+ *
+ * If an entry exists, @mas->last and @mas->index are updated accordingly.
+ * The function may set @mas->node to ``MAS_NONE``.
  *
  * Return: The entry or %NULL.
  */
@@ -6066,7 +6072,8 @@ EXPORT_SYMBOL_GPL(mas_find);
  * range.
  * @mas: The maple state
  *
- * Must hold the write lock.
+ * Context: Callers must hold the write lock.
+ *
  * Searches for @mas->index, sets @mas->index and @mas->last to the range =
and
  * erases that range.
  *
@@ -6101,7 +6108,7 @@ EXPORT_SYMBOL_GPL(mas_erase);
  * mas_nomem() - Check if there was an error allocating and do the allocat=
ion
  * if necessary If there are allocations, then free them.
  * @mas: The maple state
- * @gfp: The GFP_FLAGS to use for allocations
+ * @gfp: The ``GFP_FLAGS`` to use for allocations
  * Return: true on allocation, false otherwise.
  */
 bool mas_nomem(struct ma_state *mas, gfp_t gfp)
@@ -6178,10 +6185,12 @@ EXPORT_SYMBOL(mtree_load);
  * @index: The start of the range
  * @last: The end of the range
  * @entry: The entry to store
- * @gfp: The GFP_FLAGS to use for allocations
+ * @gfp: The ``GFP_FLAGS`` to use for allocations
  *
- * Return: 0 on success, -EINVAL on invalid request, -ENOMEM if memory cou=
ld not
- * be allocated.
+ * Return:
+ * * 0 on success
+ * * ``-EINVAL`` on invalid request
+ * * ``-ENOMEM`` if memory could not be allocated.
  */
 int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		unsigned long last, void *entry, gfp_t gfp)
@@ -6215,10 +6224,12 @@ EXPORT_SYMBOL(mtree_store_range);
  * @mt: The maple tree
  * @index: The index to store the value
  * @entry: The entry to store
- * @gfp: The GFP_FLAGS to use for allocations
+ * @gfp: The ``GFP_FLAGS`` to use for allocations
  *
- * Return: 0 on success, -EINVAL on invalid request, -ENOMEM if memory cou=
ld not
- * be allocated.
+ * Return:
+ * * 0 on success
+ * * ``-EINVAL`` on invalid request
+ * * ``-ENOMEM`` if memory could not be allocated.
  */
 int mtree_store(struct maple_tree *mt, unsigned long index, void *entry,
 		 gfp_t gfp)
@@ -6233,10 +6244,13 @@ EXPORT_SYMBOL(mtree_store);
  * @first: The start of the range
  * @last: The end of the range
  * @entry: The entry to store
- * @gfp: The GFP_FLAGS to use for allocations.
+ * @gfp: The ``GFP_FLAGS`` to use for allocations.
  *
- * Return: 0 on success, -EEXISTS if the range is occupied, -EINVAL on inv=
alid
- * request, -ENOMEM if memory could not be allocated.
+ * Return:
+ * * 0 on success
+ * * ``-EEXISTS`` if the range is occupied
+ * * ``-EINVAL`` on invalid request
+ * * ``-ENOMEM`` if memory could not be allocated.
  */
 int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 		unsigned long last, void *entry, gfp_t gfp)
@@ -6268,10 +6282,13 @@ EXPORT_SYMBOL(mtree_insert_range);
  * @mt: The maple tree
  * @index : The index to store the value
  * @entry: The entry to store
- * @gfp: The FGP_FLAGS to use for allocations.
+ * @gfp: The ``GFP_FLAGS`` to use for allocations.
  *
- * Return: 0 on success, -EEXISTS if the range is occupied, -EINVAL on inv=
alid
- * request, -ENOMEM if memory could not be allocated.
+ * Return:
+ * * 0 on success
+ * * ``-EEXISTS`` if the range is occupied
+ * * ``-EINVAL`` on invalid request
+ * * ``-ENOMEM`` if memory could not be allocated.
  */
 int mtree_insert(struct maple_tree *mt, unsigned long index, void *entry,
 		 gfp_t gfp)
@@ -6354,8 +6371,9 @@ EXPORT_SYMBOL(mtree_alloc_rrange);
  * @mt: The maple tree
  * @index: The index to erase
  *
- * Erasing is the same as a walk to an entry then a store of a NULL to that
- * ENTIRE range.  In fact, it is implemented as such using the advanced AP=
I.
+ * Erasing is the same walking to an entry then storing ``NULL`` to that
+ * entire range.  In fact, it is implemented as such using the advanced
+ * API.
  *
  * Return: The entry stored at the @index or %NULL
  */
@@ -6378,7 +6396,7 @@ EXPORT_SYMBOL(mtree_erase);
  * __mt_destroy() - Walk and free all nodes of a locked maple tree.
  * @mt: The maple tree
  *
- * Note: Does not handle locking.
+ * Note: This function does not handle locking.
  */
 void __mt_destroy(struct maple_tree *mt)
 {
@@ -6396,7 +6414,7 @@ EXPORT_SYMBOL_GPL(__mt_destroy);
  * mtree_destroy() - Destroy a maple tree
  * @mt: The maple tree
  *
- * Frees all resources used by the tree.  Handles locking.
+ * Frees all resources used by the tree. This function handles locking.
  */
 void mtree_destroy(struct maple_tree *mt)
 {
@@ -6412,7 +6430,8 @@ EXPORT_SYMBOL(mtree_destroy);
  * @index: Pointer which contains the start location of the search
  * @max: The maximum value to check
  *
- * Handles locking.  @index will be incremented to one beyond the range.
+ * This function handles locking.  @index will be incremented to one beyond
+ * the range.
  *
  * Return: The entry at or after the @index or %NULL
  */
@@ -6471,7 +6490,7 @@ EXPORT_SYMBOL(mt_find);
  * @index: Pointer which contains the start location of the search
  * @max: The maximum value to check
  *
- * Handles locking, detects wrapping on index =3D=3D 0
+ * This function handles locking and detects wrapping on ``index =3D=3D 0`=
`.
  *
  * Return: The entry at or after the @index or %NULL
  */

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--DpdX1Pe7WOtz6yvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYx7w7AAKCRD2uYlJVVFO
oyy8AP41igIGxcW92+NZmzXCrvSEAhfpKbmK6w4VjLx14AlwgQEAxrZqcY/GAdE4
QcN975L5rryg8/cLG5whsfSCply2NwI=
=TOb/
-----END PGP SIGNATURE-----

--DpdX1Pe7WOtz6yvB--
